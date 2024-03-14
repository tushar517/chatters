sealed class Result {
  const Result();
}

class Empty extends Result{
  const Empty();
}
class Loading extends Result{
  const Loading();
}

class Success<T> extends Result {
  final T data;

  @override
  String toString() {
    return 'Success{data: $data}';
  }

  const Success(this.data);
}

class Error extends Result {
  final String errorMessage;

  @override
  String toString() {
    return 'Error{errorMessage: $errorMessage}';
  }

  const Error(this.errorMessage);
}