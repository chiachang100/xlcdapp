// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:logging/logging.dart';

import 'auth.dart';
import 'data.dart';
import 'screens/joy_details.dart';
import 'screens/joys.dart';
import 'screens/manage_firestore.dart';
import 'screens/scaffold.dart';
import 'screens/scripture_details.dart';
import 'screens/scriptures.dart';
import 'screens/settings.dart';
import 'screens/sign_in.dart';
import 'widgets/fade_transition_page.dart';
import 'widgets/joy_list.dart';

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');
final joysNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'joys shell');

final xlcdlog = Logger('app_joystore');

class Joystore extends StatefulWidget {
  const Joystore({
    super.key,
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<Joystore> createState() => _JoystoreState();
}

class _JoystoreState extends State<Joystore> {
  final JoystoreAuth joyAuth = JoystoreAuth();

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'MainAppScreen',
      'xlcdapp_screen_class': 'JoystoreClass',
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          //bodyLarge: Theme.of(context).textTheme.titleLarge,
          bodyMedium: Theme.of(context).textTheme.titleMedium,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // background (button) color
            foregroundColor: Colors.white, // foreground (text) color
          ),
        ),
      ),
      builder: (context, child) {
        if (child == null) {
          throw ('No child in .router constructor builder');
        }
        return JoystoreAuthScope(
          notifier: joyAuth,
          child: child,
        );
      },
      routerConfig: GoRouter(
        observers: [Joystore.observer],
        refreshListenable: joyAuth,
        debugLogDiagnostics: true,
        initialLocation: '/joys/like',
        redirect: (context, state) {
          if (turnonSignIn) {
            if (auth.currentUser == null) {
              xlcdlog.info('Current User is signed out!');
              final signedIn = JoystoreAuth.of(context).signedIn;
              if (state.uri.toString() != '/sign-in' && !signedIn) {
                xlcdlog.info('Display sign-in screen!');
                return '/sign-in';
              }
            }
          }
          return null;
        },
        routes: [
          ShellRoute(
            navigatorKey: appShellNavigatorKey,
            builder: (context, state, child) {
              return JoystoreScaffold(
                selectedIndex: switch (state.uri.path) {
                  var p when p.startsWith('/joys') => 0,
                  var p when p.startsWith('/scriptures') => 1,
                  var p when p.startsWith('/settings') => 2,
                  _ => 0,
                },
                child: child,
              );
            },
            routes: [
              ShellRoute(
                pageBuilder: (context, state, child) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(builder: (context) {
                      return JoysScreen(
                        onTap: (idx) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            GoRouter.of(context).go(switch (idx) {
                              0 => '/joys/like',
                              1 => '/joys/new',
                              2 => '/joys/all',
                              _ => '/joys/all',
                            });
                          });
                        },
                        selectedIndex: switch (state.uri.path) {
                          var p when p.startsWith('/joys/like') => 0,
                          var p when p.startsWith('/joys/new') => 1,
                          var p when p.startsWith('/joys/all') => 2,
                          _ => 0,
                        },
                        child: child,
                      );
                    }),
                  );
                },
                routes: [
                  GoRoute(
                    path: '/joys/like',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            return JoyList(
                              joys: joystoreInstance.likeJoys,
                              isRanked: true,
                              onTap: (joy) {
                                GoRouter.of(context)
                                    .go('/joys/like/joy/${joy.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'joy/:joyId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return JoyDetailsScreen(
                            joy: joystoreInstance
                                .getJoy(state.pathParameters['joyId'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/joys/new',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            return JoyList(
                              joys: joystoreInstance.newJoys,
                              onTap: (joy) {
                                GoRouter.of(context)
                                    .go('/joys/new/joy/${joy.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'joy/:joyId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return JoyDetailsScreen(
                            joy: joystoreInstance
                                .getJoy(state.pathParameters['joyId'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/joys/all',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            joystoreInstance =
                                buildJoyStoreFromFirestore(joystoreInstance);
                            return JoyList(
                              // joys: joystoreInstance.allJoys,
                              joys: joystoreInstance.wholeJoys,
                              onTap: (joy) {
                                GoRouter.of(context)
                                    .go('/joys/all/joy/${joy.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'joy/:joyId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return JoyDetailsScreen(
                            joy: joystoreInstance
                                .getJoy(state.pathParameters['joyId'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: '/scriptures',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(builder: (context) {
                      return ScripturesScreen(
                        onTap: (scripture) {
                          GoRouter.of(context)
                              .go('/scriptures/scripture/${scripture.id}');
                        },
                      );
                    }),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'scripture/:scriptureId',
                    builder: (context, state) {
                      final scripture = joystoreInstance.allScriptures
                          .firstWhere((scripture) =>
                              scripture.id ==
                              int.parse(state.pathParameters['scriptureId']!));
                      return Builder(builder: (context) {
                        return ScriptureDetailsScreen(
                          scripture: scripture,
                          onJoyTapped: (joy) {
                            GoRouter.of(context).go('/joys/all/joy/${joy.id}');
                          },
                        );
                      });
                    },
                  )
                ],
              ),
              GoRoute(
                path: '/settings',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: SettingsScreen(firestore: widget.firestore),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/sign-in',
            builder: (context, state) {
              return Builder(
                builder: (context) {
                  return SignInScreen(
                    onSignIn: (value) async {
                      final router = GoRouter.of(context);
                      await JoystoreAuth.of(context)
                          .signIn(value.email, value.password);
                      router.go('/joys/all');
                    },
                  );
                },
              );
            },
          ),
          GoRoute(
            path: '/manage-firestore',
            pageBuilder: (context, state) {
              return FadeTransitionPage<dynamic>(
                key: state.pageKey,
                child: ManageFirestoreScreen(firestore: widget.firestore),
              );
            },
          ),
        ],
      ),
    );
  }
}
