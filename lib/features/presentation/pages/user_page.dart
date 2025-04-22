import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/features/data/datasource/user_remote_data_source.dart';
import 'package:new_project/features/domain/usecases/create_usecase.dart';
import 'package:new_project/features/domain/usecases/delete_usecase.dart';
import 'package:new_project/features/domain/usecases/get_users_list_usecase.dart';
import 'package:new_project/features/domain/usecases/update_usecase.dart';

import '../../../user_injection.dart';
import '../../data/repositories/user_list_repository_impl.dart';
import '../../domain/entities/user_list_entity.dart';
import '../bloc/user_list/user_list_bloc.dart';
import '../bloc/user_list/user_list_event.dart';
import '../bloc/user_list/user_list_state.dart';


class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: BlocProvider(
        create: (_) => UserListBloc(
            sl<GetUsersListUseCase>(),
            sl<CreateUserUseCase>(),
            sl<DeleteUserUseCase>(),
            sl<UpdateUserUseCase>(),),
        child: BlocBuilder<UserListBloc, UserListState>(
          builder: (context, state) {
            if (state is UserListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserListLoaded) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(context, user);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<UserListBloc>().add(DeleteUserEvent(user.id));
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is UserListError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    final nameController = TextEditingController();
    final jobController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: jobController, decoration: const InputDecoration(labelText: 'Job')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              context.read<UserListBloc>().add(CreateUserEvent(nameController.text, jobController.text));
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, UserListEntity user) {
    final nameController = TextEditingController(text: '${user.firstName} ${user.lastName}');
    final jobController = TextEditingController(); // Assume you want to edit the job

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: jobController, decoration: const InputDecoration(labelText: 'Job')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              context.read<UserListBloc>().add(UpdateUserEvent(user.id, nameController.text, jobController.text));
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

}

