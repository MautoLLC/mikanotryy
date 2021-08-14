class QIBusBookingModel {
  var technician;
  var duration;
  var startTime;
  var comments;

  QIBusBookingModel(this.technician, this.duration ,this.comments,this.startTime);

  QIBusBookingModel.booking(
      this.technician, this.startTime,this.duration,this.comments);
}