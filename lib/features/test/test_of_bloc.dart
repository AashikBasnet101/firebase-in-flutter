import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprojectfirebase/features/test/api_sucess_page.dart';
import 'package:newprojectfirebase/features/test/test_bloc.dart';
import 'package:newprojectfirebase/features/test/test_event.dart';
import 'package:newprojectfirebase/features/test/test_state.dart';

class TestOfBloc extends StatelessWidget {
  const TestOfBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(' working on bloc')),

      // API LISTENER
      body: BlocListener<ApiBloc, ApiState>(
        listener: (context, state) {
          if (state is ApiLoadedState) {
            // Navigate on success
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ApiSuccessPage(posts: state.posts),
              ),
            );
          }

          if (state is ApiErrorState) {
            // Show error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              // -------- COUNTER ----------
              const SizedBox(height: 50),
              BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  return Text(
                    "${state.count}",
                    style: const TextStyle(fontSize: 40),
                  );
                },
              ),

              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<CounterBloc>().add(IncrementEvent()),
                      child: const Text("Add"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<CounterBloc>().add(DecrementEvent()),
                      child: const Text("Subtract"),
                    ),
                  ),
                ],
              ),

              // -------- PASSWORD ----------
              const SizedBox(height: 40),
              BlocBuilder<PasswordBloc, PasswordState>(
                builder: (context, state) {
                  return TextFormField(
                    obscureText: !state.isVisible,
                    decoration: InputDecoration(
                      labelText: "Enter Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.isVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          context
                              .read<PasswordBloc>()
                              .add(TogglePasswordVisibility());
                        },
                      ),
                    ),
                  );
                },
              ),

              // -------- API BUTTON ----------
              const SizedBox(height: 40),

              BlocBuilder<ApiBloc, ApiState>(
                builder: (context, state) {
                  if (state is ApiLoadingState) {
                    return const CircularProgressIndicator();
                  }

                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ApiBloc>().add(FetchDataEvent());
                      },
                      child: const Text("Fetch API Data"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

