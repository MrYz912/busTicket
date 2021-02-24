import { Button, Card, List, WingBlank } from 'antd-mobile';
import './index.css';

const Item = List.Item;

function Home (){
  return (
    <div className="Home">
      {/* <NoticeBar mode="link" onClick={() => alert('1')} marqueeProps={{ loop: true}}>
        温馨提示：旅客们请注意，根据广东省疫情防控指挥部有关通知，旅客进站购票和乘车必须佩戴口罩！祝您健康！旅途愉快！
      </NoticeBar> */}
      <img alt="" src="https://dimg04.c-ctrip.com/images/zg0o1f000001g208lD72B.jpg"
        style={{width: "100%", height: "204.7px"}}></img>
      <WingBlank size="md">
        <Card style={{marginTop: "-40px", padding: "15px 15px 15px 8px"}}>
          <List className="choiceList" style={{marginBottom: "10px"}}>
            <Item arrow="horizontal" onClick={() => {}} extra="广州市桥汽车站">
              <img alt="起点" src="https://tva1.sinaimg.cn/large/008eGmZEgy1gnqw6vnr98j305k05ka9y.jpg"></img>
              出发站
            </Item>
            <Item arrow="horizontal" onClick={() => {}} extra="广州天河客运站">
              <img alt="终点" src="https://tva1.sinaimg.cn/large/008eGmZEgy1gnqw8j2nxgj305k05kmx4.jpg"></img>
              到达站
            </Item>
            <Item arrow="horizontal" onClick={() => {}} extra="2021-02-25 周四">
              <img alt="日期" src="https://tva1.sinaimg.cn/large/008eGmZEgy1gnqwi4r9uej305k05kmx4.jpg"></img>
              日期
            </Item>
          </List>
          <WingBlank size="md">
            <Button type={'primary'}>查询</Button>
          </WingBlank>
        </Card>
      </WingBlank>
      <Button icon={<img src="https://tva1.sinaimg.cn/large/008eGmZEgy1gnr25ujhkej305k05kq2v.jpg" alt="个人中心" style={{margin: "0"}}/>}
        style={{position: "absolute", bottom: "60px", right: "60px", borderRadius: "50%", width: "47px", boxShadow: "0 1px 3px 1px rgb(0 0 0 / 20%)"}}>
      </Button>
    </div>
  );
}

export default Home;