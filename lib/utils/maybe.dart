enum _Maybe { just, nothing }

abstract class Maybe<V> {
  _Maybe get _type;

  T join<T>(T nothing(), T just(V v)) {
    switch (_type) {
      case _Maybe.nothing:
        return nothing();
      default:
        return just((this as Just).value);
    }
  }

  bool isJust() => _type == _Maybe.just;
  bool isNothing() => _type == _Maybe.nothing;

  @override
  bool operator ==(Object other) =>
      other is Nothing<V> && this is Nothing<V> ||
      other is Just<V> &&
          this is Just<V> &&
          other.value == (this as Just<V>).value;

  Object _valueObject() {
    if (this is Just<V>) {
      return (this as Just<V>).value;
    }
    return null;
  }

  @override
  int get hashCode => _type.hashCode ^ _valueObject()?.hashCode;
}

class Nothing<V> extends Maybe<V> {
  _Maybe get _type => _Maybe.nothing;
}

class Just<V> extends Maybe<V> {
  Just(this._value);

  final V _value;

  V get value => _value;

  _Maybe get _type => _Maybe.just;
}

Maybe<T> _json2Maybe<T>(T json) {
  if (json != null) return Just(json);
  return Nothing();
}

Maybe<String> json2MaybeString(String v) => _json2Maybe(v);

dynamic maybe2Json(Maybe<dynamic> v) {
  return v.join(() => null, (v) => v);
}

//String maybeString2Json (Maybe<String> v) => _maybe2Json(v);
