import 'package:flutter/material.dart';
import 'package:flutter_push_notification/src/app/screens/activity/activity_controller.dart';
import 'package:flutter_push_notification/src/app/screens/activity/activity_shimer.dart';
import 'package:flutter_push_notification/src/domain/notification/lib/repositories/activity_repository.dart';

import 'package:watch_it/watch_it.dart';


final ActivityRespository _activityRespository = di<ActivityRespository>();

class ActivityScreen extends StatefulWidget with WatchItStatefulWidgetMixin {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = watchValue((BuyerActivityController x) => x.isLoading);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                color: theme.colorScheme.background,
                height: 120,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/images/listing/topbar2.png",
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: 120,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Activity log',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          isLoading
              ? const Expanded(child: ActivityShimmerEffect())
              : Expanded(
                  child: _activityRespository.activtyLogsModel?.data.isEmpty ??
                          true
                      ? Center(
                          child: Text(
                            'No activity',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        )
                      : MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            itemCount: _activityRespository
                                .activtyLogsModel!.data.length,
                            itemBuilder: (context, index) {
                              final activity = _activityRespository
                                  .activtyLogsModel!.data[index];


                              return Dismissible(
                                key: Key(activity.id),
                                direction: DismissDirection.horizontal,
                                background: Container(
                                  color: Colors.red,
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.red,
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  if (direction ==
                                          DismissDirection.endToStart ||
                                      direction ==
                                          DismissDirection.startToEnd) {
                                    final bool? result = await showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm"),
                                          content: const Text(
                                            "Are you sure you want to delete this item?",
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text("DELETE"),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text("CANCEL"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return result ?? false;
                                  } else {
                                    return false;
                                  }
                                },
                                onDismissed: (DismissDirection direction) {
                                  setState(() {
                                    _activityRespository.activtyLogsModel!.data
                                        .removeAt(index);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        direction == DismissDirection.endToStart
                                            ? 'Deleted'
                                            : 'Deleted',
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 8, 15, 0),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            theme.shadowColor.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 40.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: theme
                                                  .colorScheme.onInverseSurface,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ClipOval(
                                              child: Image.network(
                                                activity
                                                    .fromUser.profileImageUrl,
                                                fit: BoxFit.cover,
                                                width: 40,
                                                height: 40,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object error,
                                                    StackTrace? stackTrace) {
                                                  return Icon(
                                                    Icons.image,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : theme.colorScheme
                                                            .primary,
                                                    size: 20,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      activity
                                                          .fromUser.firstname,
                                                      style: theme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                        color: theme.colorScheme
                                                            .onSurface,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      activity
                                                          .fromUser.lastname,
                                                      style: theme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                        color: theme.colorScheme
                                                            .onSurface,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  activity.body,
                                                    maxLines: 2,
                                                  style: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                    color: theme
                                                        .colorScheme.onSurface,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "2:00",
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                    color: theme
                                                        .colorScheme.onSurface,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Icon(Icons.chevron_right),
                                        ],
                                      ),
                                      if (activity.noti_type ==
                                              "Folder Invite" ||
                                          activity.noti_type ==
                                              "Collaborator Invite")
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    side: BorderSide(
                                                        color: theme
                                                            .colorScheme.error),
                                                    backgroundColor:
                                                        theme.colorScheme.error,
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text("Reject"),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    side: BorderSide(
                                                        color: theme
                                                            .colorScheme.scrim),
                                                    backgroundColor:
                                                        theme.colorScheme.scrim,
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text("Accept"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
        ],
      ),
    );
  }
}
