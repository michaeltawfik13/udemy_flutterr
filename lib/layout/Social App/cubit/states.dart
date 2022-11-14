import 'package:udemy_flutterr/layout/Social%20App/social_layout.dart';

abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

// Get User Data
class SocialGetUserLoading extends SocialStates{}

class SocialGetUserSuccess extends SocialStates{}

class SocialGetUserError extends SocialStates
{
  final String error;
  SocialGetUserError(this.error);
}

//Get All users
class SocialGetAllUserLoading extends SocialStates{}

class SocialGetAllUserSuccess extends SocialStates{}

class SocialGetAllUserError extends SocialStates
{
  final String error;
  SocialGetAllUserError(this.error);
}


// Get Posts
class SocialGetPostsLoading extends SocialStates{}

class SocialGetPostsSuccess extends SocialStates{}

class SocialGetPostsError extends SocialStates
{
  final String error;
  SocialGetPostsError(this.error);
}

//Get Likes
class SocialLikesPostsSuccess extends SocialStates{}

class SocialLikesPostsError extends SocialStates
{
  final String error;
  SocialLikesPostsError(this.error);
}

class SocialChangeBottomState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUpdateUserErrorState extends SocialStates{}

class SocialUpdateUserLoadingState extends SocialStates{}

//create post
class SocialCreatePostLoading extends SocialStates{}

class SocialCreatePostSuccess extends SocialStates{}

class SocialCreatePostError extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}

//messages
class SocialSendMessageSuccess extends SocialStates{}

class SocialSendMessageError extends SocialStates {}

class SocialGetMessageSuccess extends SocialStates{}




