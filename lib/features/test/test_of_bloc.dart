import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprojectfirebase/features/test/test_bloc.dart';
import 'package:newprojectfirebase/features/test/test_event.dart';
import 'package:newprojectfirebase/features/test/test_state.dart';
import 'package:newprojectfirebase/features/widgets/custom_elevated_button.dart';

class TestOfBloc extends StatelessWidget {
  const TestOfBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add and Subtract Bloc')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text("${state.count}", style: const TextStyle(fontSize: 40));
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<CounterBloc>().add(IncrementEvent()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 8),
                          Text("Add", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<CounterBloc>().add(DecrementEvent()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.delete, color: Colors.white),
                          SizedBox(width: 8),
                          Text("Subtract", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            BlocBuilder<PasswordBloc, PasswordState>(
              builder: (context, state) {
                return TextFormField(
                  obscureText: !state.isVisible,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        context
                            .read<PasswordBloc>()
                            .add(TogglePasswordVisibility());
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
