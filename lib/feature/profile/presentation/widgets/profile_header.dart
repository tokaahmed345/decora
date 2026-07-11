// import 'dart:io';
// import 'package:decora/core/utils/service_locator/service_locator.dart';
// import 'package:decora/feature/auth/presentation/widgets/auth_header_clipper.dart';
// import 'package:decora/feature/profile/presentation/cubit/cubit/image_profile_cubit.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// class ProfileHeader extends StatefulWidget {
//   const ProfileHeader({super.key});

//   @override
//   State<ProfileHeader> createState() => _ProfileHeaderState();
// }

// class _ProfileHeaderState extends State<ProfileHeader> {
//   File? _pickedImage;
//   final String userId = getIt.get<FirebaseAuth>().currentUser!.uid;

//   Future<void> _onEditAvatarTap() async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 85,
//     );

//     if (picked == null) return;
//     if (!mounted) return;

//     final file = File(picked.path);

//     setState(() {
//       _pickedImage = file;
//     });

//     context.read<ImageProfileCubit>().uploadImage(userId, file);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 240,
//       width: double.infinity,
//       child: ClipPath(
//         clipper: const AuthHeaderClipper(),
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Color(0xFFE07A4F), Color(0xFFD56E49)],
//             ),
//           ),
//           child: Column(
            
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               BlocConsumer<ImageProfileCubit, ImageProfileState>(
//                 listener: (context, state) {
//                   if (state is ImageProfileFailure) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text(state.errorMessage)),
//                     );
//                   }
//                   if (state is ImageProfileSuccess) {
//                     setState(() => _pickedImage = null);
//                   }
//                 },
//                 builder: (context, state) {
//                   final cubitUrl =
//                       state is ImageProfileSuccess ? state.imageUrl : null;
//                   final name =
//                       state is ImageProfileSuccess ? state.name : '';
          
//                   return Column(
//                                         mainAxisSize: MainAxisSize.min, // 👈 مهم

//                     children: [
//                       Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(3),
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white,
//                             ),
//                             child: CircleAvatar(
//                               radius: 44,
//                               backgroundColor: Colors.white,
//                               backgroundImage: _pickedImage != null
//                                   ? FileImage(_pickedImage!) as ImageProvider
//                                   : (cubitUrl != null && cubitUrl.isNotEmpty)
//                                       ? NetworkImage(cubitUrl)
//                                       : null,
//                               child: (_pickedImage == null &&
//                                       (cubitUrl == null || cubitUrl.isEmpty))
//                                   ? const Icon(
//                                       Icons.person,
//                                       size: 44,
//                                       color: Colors.grey,
//                                     )
//                                   : null,
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: GestureDetector(
//                               onTap: _onEditAvatarTap,
//                               child: Container(
//                                 padding: const EdgeInsets.all(7),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFF2B84B),
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                       color: Colors.white, width: 2),
//                                 ),
//                                 child: const Icon(
//                                   Icons.camera_alt,
//                                   size: 14,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         name.isNotEmpty ? name : 'User',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//               const SizedBox(height: 50),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:io';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/auth/presentation/widgets/auth_header_clipper.dart';
import 'package:decora/feature/profile/presentation/cubit/cubit/image_profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  File? _pickedImage;
  final String userId = getIt.get<FirebaseAuth>().currentUser!.uid;

  Future<void> _onEditAvatarTap() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (picked == null) return;
    if (!mounted) return;

    final file = File(picked.path);

    setState(() {
      _pickedImage = file;
    });

    context.read<ImageProfileCubit>().uploadImage(userId, file);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: ClipPath(
        clipper: const AuthHeaderClipper(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE07A4F), Color(0xFFD56E49)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<ImageProfileCubit, ImageProfileState>(
                listener: (context, state) {
                  if (state is ImageProfileFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)),
                    );
                  }
                  if (state is ImageProfileSuccess) {
                    setState(() => _pickedImage = null);
                  }
                },
                builder: (context, state) {
             
                  String name = '';
                  String? cubitUrl;

                  if (state is ImageProfileSuccess) {
                    name = state.name;
                    cubitUrl = state.imageUrl;
                  } else if (state is ImageProfileLoading ) {
                    name = state.name??"";
                    cubitUrl = state.imageUrl;
                  }

                  final isUploading = state is ImageProfileLoading;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 44,
                                  backgroundColor: Colors.white,
                                  backgroundImage: _pickedImage != null
                                      ? FileImage(_pickedImage!)
                                          as ImageProvider
                                      : (cubitUrl != null &&
                                              cubitUrl.isNotEmpty)
                                          ? NetworkImage(cubitUrl)
                                          : null,
                                  child: (_pickedImage == null &&
                                          (cubitUrl == null ||
                                              cubitUrl.isEmpty))
                                      ? const Icon(
                                          Icons.person,
                                          size: 44,
                                          color: Colors.grey,
                                        )
                                      : null,
                                ),
                                // if (isUploading)
                                //   Container(
                                //     width: 88,
                                //     height: 88,
                                //     decoration: const BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: Colors.black38,
                                //     ),
                                //     child: const Center(
                                //       child: SizedBox(
                                //         width: 24,
                                //         height: 24,
                                //         child: CircularProgressIndicator(
                                //           strokeWidth: 2.5,
                                //           color: Colors.white,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: isUploading ? null : _onEditAvatarTap,
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2B84B),
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        name.isNotEmpty ? name : 'User',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}