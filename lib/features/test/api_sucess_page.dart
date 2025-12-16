import 'package:flutter/material.dart';
import 'package:newprojectfirebase/features/test/post_models.dart';

class ApiSuccessPage extends StatelessWidget {
  final List<Post> posts;

  const ApiSuccessPage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            )
    );
  }
      }
    
