import { NavBar, Icon, Tabs, Button } from 'antd-mobile';
import List from './components/listView';
import './index.css';

const tabs = [
  { title: 'First Tab', key: 't1' },
  { title: 'Second Tab', key: 't2' },
  { title: 'Third Tab', key: 't3' },
  { title: 'First Tab', key: 't4' },
  { title: 'Second Tab', key: 't5' },
  { title: 'Third Tab', key: 't6' },
  { title: 'First Tab', key: 't7' },
];

function RenderTab() {
  return (
    <Button className="tab-button" style={{fontSize: "12px"}}>
      <div style={{height: "100%", lineHeight: "normal"}}>
        <div style={{height: "50%", verticalAlign: "center"}}>02/21</div>
        <div style={{height: "50%", verticalAlign: "center"}}>今天</div>
      </div>
    </Button>
  )
}

function BusList (){
  return (
    <div className="bus-list">
        <div className="top-container">
          <NavBar
            mode="light"
            icon={<Icon type="left" />}
            onLeftClick={() => console.log('onLeftClick')}
          >广州市桥汽车站 - 广州天河客运站</NavBar>
          <div className="tab-container" style={{display: "flex"}}>
            <Tabs tabs={tabs}
              initialPage={'t2'}
              renderTab={RenderTab}
              style={{flex: "1"}}
            >
            </Tabs>
            <div style={{width: "50px", background: "#fff"}}>
              <img alt="日期" src="https://tva1.sinaimg.cn/large/008eGmZEgy1gnwo27ixhej305k05kwea.jpg"></img>
              <Icon id="dateIcon" type="down"></Icon>
            </div>
          </div>
        </div>
        <List></List>
        <Button className="buslist-tool">方案排序</Button>
    </div>
  );
}

export default BusList;