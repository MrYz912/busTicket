import { Calendar } from 'antd-mobile';

const now = new Date();

function onConfirm(startTime, endTime) {
  document.getElementsByTagName('body')[0].style.overflowY = this.originbodyScrollY;
  this.setState({
    show: false,
    startTime,
    endTime,
  });
}

function onCancel() {
  document.getElementsByTagName('body')[0].style.overflowY = this.originbodyScrollY;
  this.setState({
    show: false,
    startTime: undefined,
    endTime: undefined,
  });
}

function DateChoice (){
  
  return (
    <div className="date-choice">
      <Calendar
        // {...this.state.config}
        // visible={this.state.show}
        onCancel={onCancel}
        onConfirm={onConfirm}
        // onSelectHasDisableDate={this.onSelectHasDisableDate}
        // getDateExtra={this.getDateExtra}
        defaultDate={now}
        minDate={new Date(+now - 5184000000)}
        maxDate={new Date(+now + 31536000000)}
      />
    </div>
  );
}

export default DateChoice;