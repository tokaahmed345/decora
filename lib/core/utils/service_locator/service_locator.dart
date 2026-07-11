
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dentiq/features/tips/data/repo/articles_repo/article_repo_impl.dart';
// import 'package:dentiq/features/tips/data/repo/video_repo/video_repo.dart';
// import 'package:dentiq/features/tips/data/repo/video_repo/video_repo_impl.dart';
// import 'package:dentiq/features/tips/presentation/view_model/article_cubit/articles_cubit.dart';
// import 'package:dentiq/features/tips/presentation/view_model/videos_cubit/videos_cubit_cubit.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get_it/get_it.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// final getIt = GetIt.instance;
// void setUp(){
//   getIt.registerLazySingleton<FirebaseAuth>(()=>FirebaseAuth.instance);
  
//     getIt.registerLazySingleton<FirebaseFirestore>(()=>FirebaseFirestore.instance);
// getIt.registerLazySingleton<SharedPrefs>(() => SharedPrefs());
//   getIt.registerLazySingleton<Dio>(() => Dio());
//   getIt.registerLazySingleton<ApiService>(
//       () => DioConsumer(dio: getIt<Dio>()));

// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decora/core/utils/service/api_service.dart';
import 'package:decora/core/utils/service/dio_consumer.dart';
import 'package:decora/core/utils/sharedprefrence.dart';
import 'package:decora/feature/ai_analyzer/data/data_source/room_analyzer_data_source.dart';
import 'package:decora/feature/ai_analyzer/data/repo_impl/repo_analyzer_repo_impl.dart';
import 'package:decora/feature/ai_analyzer/presentation/cubits/cubit/room_analyzer_cubit.dart';
import 'package:decora/feature/auth/data/data_source/forgot_remote_data_source.dart';
import 'package:decora/feature/auth/data/data_source/log_in_remote_data_source.dart';
import 'package:decora/feature/auth/data/repo_impl/forgot_password_repo_impl.dart';
import 'package:decora/feature/auth/data/repo_impl/log_in_repo_impl.dart';
import 'package:decora/feature/auth/presentation/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:decora/feature/auth/presentation/cubits/log_in_cubit/log_in_cubit.dart';
import 'package:decora/feature/auth/presentation/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:decora/feature/chat/data/data_source/chat_remote_data_source.dart';
import 'package:decora/feature/chat/data/repo_impl/chat_repo_impl.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';
import 'package:decora/feature/chat/presentation/cubits/create_cubit/create_chat_cubit.dart';
import 'package:decora/feature/chat/presentation/cubits/get_chat_cubit/get_chats_cubit.dart';
import 'package:decora/feature/chat/presentation/cubits/get_messages_cubit/get_messages_cubit.dart';
import 'package:decora/feature/chat/presentation/cubits/search_cubit/cubit/search_users_cubit.dart';
import 'package:decora/feature/chat/presentation/cubits/send_messages_cubit/send_messages_cubit.dart';
import 'package:decora/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:decora/feature/home/data/repo_impl/home_repo_impl.dart';
import 'package:decora/feature/home/presentation/cubits/Home_cubit/home_cubit_cubit.dart';
import 'package:decora/feature/notification/data/notification_remote_data_layer.dart/data_source/notification_remote_data.dart';
import 'package:decora/feature/profile/data/data_source/upload_profile_image_remote_data_source.dart';
import 'package:decora/feature/profile/data/domain/repo/upload_image_repo.dart';
import 'package:decora/feature/profile/data/repo_impl/upload_image_repo_impl.dart';
import 'package:decora/feature/profile/presentation/cubit/cubit/image_profile_cubit.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import 'package:decora/feature/auth/data/data_source/sign_up_remote_data_source.dart';
import 'package:decora/feature/auth/data/repo_impl/sign_up_repo_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
   getIt.registerLazySingleton<SupabaseClient>(()=>Supabase.instance.client);

  getIt.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);

getIt.registerLazySingleton<SharedPrefs>(() => SharedPrefs());

  getIt.registerLazySingleton<SignUpRemoteDataSource>(
    () => SignUpRemoteDataSource(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerLazySingleton<SignUpRepoImpl>(
    () => SignUpRepoImpl(
      remoteDataSource: getIt<SignUpRemoteDataSource>(),
      sharedPrefs: getIt<SharedPrefs>(),
    ),
  );
  getIt.registerFactory<SignUpCubit>(
    () =>SignUpCubit()
  );
    getIt.registerLazySingleton<LogInRemoteDataSource>(
    () => LogInRemoteDataSource(
      firebaseAuth: getIt<FirebaseAuth>(),           firestore: getIt<FirebaseFirestore>(),

    )
  );
   getIt.registerLazySingleton<ForgotRemoteDataSource>(
    () => ForgotRemoteDataSource(
      firebaseAuth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerLazySingleton<LogInRepoImpl>(
    () => LogInRepoImpl(
      remoteDataSource: getIt<LogInRemoteDataSource>(),
      sharedPrefs: getIt<SharedPrefs>(),
    ),
  );
    getIt.registerLazySingleton<ForgotPasswordRepoImpl>(
    () =>ForgotPasswordRepoImpl (
      remoteDataSource: getIt<ForgotRemoteDataSource>(),
    ),
  );
    getIt.registerFactory<LogInCubit>(
    () =>LogInCubit()
  );
      getIt.registerFactory<ForgotPasswordCubit>(
    () =>ForgotPasswordCubit()
  );

  getIt.registerLazySingleton<Dio>(() => Dio());
getIt.registerLazySingleton<ApiService>(
    () => DioConsumer(dio: getIt<Dio>()));

getIt.registerLazySingleton<HomeRemoteDataSource>(
  () => HomeRemoteDataSource(
          firestore: getIt<FirebaseFirestore>(),

  ),
);

getIt.registerLazySingleton<HomeRepoImpl>(
  () => HomeRepoImpl(
    remoteDataSource: getIt<HomeRemoteDataSource>(),
  ),
);

getIt.registerFactory<HomeCubit>(
  () => HomeCubit(),
);



getIt.registerLazySingleton<AiSuggestionDataSource>(
  () => AiSuggestionDataSource(
          apiService: getIt.get<ApiService>(),

  ),
);

getIt.registerLazySingleton<RoomAnalyzerRepoImpl>(
  () => RoomAnalyzerRepoImpl(
    aiSuggestionDataSource: getIt<AiSuggestionDataSource>(),
  ),
);
getIt.registerLazySingleton<NotificationRemoteData>(
  () => NotificationRemoteData(
  ),
);

getIt.registerFactory<RoomAnalyzerCubit>(
  () => RoomAnalyzerCubit(),
);
getIt.registerLazySingleton<  ChatRemoteDataSourceImpl>(
  () => ChatRemoteDataSourceImpl(
    supabase: getIt<SupabaseClient>(),
          getIt<FirebaseFirestore>(), notificationRemoteData: getIt<NotificationRemoteData>(),

  ),
);

getIt.registerLazySingleton<  UploadProfileImageRemoteDataSource>(
  () =>UploadProfileImageRemoteDataSource (
           supabase: getIt<SupabaseClient>(), firestore: getIt<FirebaseFirestore>(),

  ),
);
getIt.registerLazySingleton<ChatRepoImpl>(
  () => ChatRepoImpl(
    chatRemoteDataSource: getIt<ChatRemoteDataSourceImpl>(),
  ),
);


getIt.registerLazySingleton<ChatRepo>(
  () => ChatRepoImpl(
    chatRemoteDataSource: getIt<ChatRemoteDataSourceImpl>(),
  ),
);

getIt.registerLazySingleton<UploadImageRepo>(
  () => UploadImageRepoImpl(
    remoteDataSource: getIt<UploadProfileImageRemoteDataSource>(),
  ),
);

getIt.registerFactory<GetChatsCubit>(
  () => GetChatsCubit(),
);

getIt.registerFactory<CreateChatCubit>(
  () => CreateChatCubit(),
);


getIt.registerFactory<SearchUsersCubit>(
  () => SearchUsersCubit(),
);
getIt.registerFactory<GetMessagesCubit>(
  () => GetMessagesCubit(),
);
getIt.registerFactory<SendMessagesCubit>(
  () => SendMessagesCubit(),
);


// getIt.registerFactory<ImageProfileCubit>(
//   () => ImageProfileCubit(getIt.get<UploadImageRepo>()),
// );
getIt.registerLazySingleton<ImageProfileCubit>(() => ImageProfileCubit(getIt.get<UploadImageRepo>()));



}