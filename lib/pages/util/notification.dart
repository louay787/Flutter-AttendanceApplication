class Notification {
  final String title;
  final String message;

  Notification(this.title, this.message);
}

List<Notification> notifications = [
  Notification(
    'SecurityCheck :',
    'Check the Door someone Unkown',
  ),
  Notification(
      'WorkersMangment :', 'Louay Salem is absent--> Id:95-DVP-4221-NBG'),
  Notification('SensorWarning :', 'Humidity Sensor Warrning'),
  Notification('BarraMrigl :', 'O55555555'),
];
