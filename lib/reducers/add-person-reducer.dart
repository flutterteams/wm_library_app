import 'package:redux/redux.dart';
import 'package:wm_library_app/model/book.dart';
import 'package:wm_library_app/model/person.dart';

final AddPersonReducer = combineReducers<Person>([
  TypedReducer<Person, ChangePersonAction>(_changeAll),
  TypedReducer<Person, ChangePersonEmailAction>(_changeEmail),
  TypedReducer<Person, ChangePersonTypeAction>(_changeType),

]);

Person _changeAll(Person person, action) {
  person = action.person;
  return person;
}

Person _changePerson(Person person, action) {
  print(person.email);
  person = new Person(person.name, person.email, person.phone, person.status, person.id);
  return person;
}

Person _changeEmail(Person person, action) {
  print("====actionname===="+action.email);
  person = new Person(person.name, action.email == '' ? null : action.email, person.phone, person.status, person.id);
 return person;
}


Person _changeType(Person person, action) {
  person = new Person(person.name , person.email, person.phone, action.status == '' ? null : action.name, person.id);

  return person;
}

class ChangePersonAction {
  final Person person;
  ChangePersonAction(this.person);
}

class ChangePersonTypeAction {
  final String id;
  ChangePersonTypeAction(this.id);
}

class ChangePersonEmailAction {
  final String email;
  ChangePersonEmailAction(this.email);
}
