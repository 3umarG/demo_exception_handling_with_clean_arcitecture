import 'package:demo_exception_handling_with_clean_arcitecture/core/ui/enums/api_state.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/features/posts/presentation/controller/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    child: const MyApp(),
    create: (BuildContext context) => PostsProvider(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: Consumer<PostsProvider>(builder: (context, provider, _) {
        return provider.fetchPostsState == ApiState.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : provider.fetchPostsState == ApiState.success
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'You have pushed the button this many times:',
                        ),
                        Text(
                          'counter',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Text("Error Cause : ${provider.errorMessage}"),
                  );
      }),
    );
  }
}
