abstract class NewsStates{}


class InitialState extends NewsStates{}

class NewsBottomNav extends NewsStates{}

//Business
class NewsGetLoadingbusinessState extends NewsStates{}

class NewsGetBusinessSuccess extends NewsStates{}

class NewsGetBusinessError extends NewsStates
{
  late final String error;

  NewsGetBusinessError(this.error);
}

//Sports
class NewsGetLoadingSportsState extends NewsStates{}

class NewsGetSportsSuccess extends NewsStates{}

class NewsGetSportsError extends NewsStates
{
  late final String error;

  NewsGetSportsError(this.error);
}


//Science
class NewsGetLoadingScienceState extends NewsStates{}

class NewsGetScienceSuccess extends NewsStates{}

class NewsGetScienceError extends NewsStates
{
  late final String error;

  NewsGetScienceError(this.error);
}

class NewsSettings extends NewsStates{}

class NewsGetLoadingSearchState extends NewsStates{}

class NewsGetSearchSuccess extends NewsStates{}

class NewsGetSearchError extends NewsStates
{
  late final String error;

  NewsGetSearchError(this.error);
}