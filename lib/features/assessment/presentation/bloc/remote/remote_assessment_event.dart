abstract class RemoteAsssessmentsEvent {
  const RemoteAsssessmentsEvent();
}

class GetAsssessments extends RemoteAsssessmentsEvent {
  final String pageKey;

  const GetAsssessments(this.pageKey);

  List<Object> get props => [pageKey];
}

class GetSavedAsssessments extends RemoteAsssessmentsEvent {
  const GetSavedAsssessments();

  List<Object> get props => [];
}
