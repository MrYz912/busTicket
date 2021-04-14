// import moment from 'moment';

export function timeFormatter(time) {
  const temp = time.split('.')[0].split(':');
  return temp[0] + ':' + temp[1];
}