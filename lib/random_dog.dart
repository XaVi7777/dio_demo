import 'package:dio_demo/random_dog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomDog extends StatefulWidget {
  const RandomDog({super.key});

  @override
  State<RandomDog> createState() => _RandomDogState();
}

class _RandomDogState extends State<RandomDog> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RandomDogBloc>(
      create: (context) => RandomDogBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<RandomDogBloc, RandomDogState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 30),
                    if (state is RandomDogStateInitial)
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                    else if (state is RandomDogStateLoading)
                      Container(
                        width: double.infinity,
                        height: 300,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    else if (state is RandomDogStateSuccess)
                      SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: Image.network(state.data.message),
                      ),

                    Spacer(),
                    ElevatedButton(
                      onPressed: () => context.read<RandomDogBloc>().add(
                        RandomDogLoadEvent(),
                      ),
                      child: Text('Get random dog'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
