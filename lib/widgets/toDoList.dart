import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
  ToDoItem({ Key key, this.name, this.index, this.eraseElement }) : super(key: key);
  
  final String name;
  final num index;
  final ItemCallback eraseElement;
  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: () {
        print('you clicked $name');
      },
      child: ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child:
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[ 
              RichText(
                text: TextSpan(
                text: name
              )
            ),
            IconButton(
              icon: Icon(Icons.close, size: 20.0,),
              tooltip: 'Delete Element',
              onPressed: () {
                eraseElement(index);
              },
            )
          ]
        ),
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(vertical :5.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: Colors.grey[400],
      )
    )
    );
  }
}

typedef ItemCallback = void Function(num index);


class TodoList extends StatefulWidget {

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  final List <String> _toDoList = new List<String>();
  final TextEditingController eCtrl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _incrementList(_newValue) {
    setState(() {
      _toDoList.add(_newValue);
    });
  }

  void _eraseElement(_index) {
    setState(() {
      _toDoList.removeAt(_index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(5.0),
      child: Center(
          child: (
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: eCtrl,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Agrega un titulo a la tarea';
                      }
                      return null;
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _incrementList(eCtrl.text);
                        eCtrl.clear();
                      }
                    },
                    child: Text('Agregar To Do'),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: _toDoList == null ? Container() : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _toDoList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return ToDoItem(name :_toDoList[index], index: index, eraseElement: _eraseElement);
                      },
                    ),
                  )
                 )
                ],
              ),
            )
          ),
      ),
    );
  }
}