import { NavBar, Icon, Tabs, Button } from 'antd-mobile';
import './index.css'
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
    <Button style={{fontSize: "12px"}}>
      <div style={{height: "100%", lineHeight: "normal"}}>
        <div style={{height: "50%", verticalAlign: "center"}}>02/21</div>
        <div style={{height: "50%", verticalAlign: "center"}}>今天</div>
      </div>
    </Button>
  )
}

function BusList (){
  return (
    <div className="BusList">
        <div className="topContainer" style={{position: "sticky", top:"0"}}>
          <NavBar
            mode="light"
            icon={<Icon type="left" />}
            onLeftClick={() => console.log('onLeftClick')}
          >广州市桥汽车站 - 广州天河客运站</NavBar>
          <div className="tabContainer">
            <Tabs tabs={tabs}
              initialPage={'t2'}
              renderTab={RenderTab}
            >
              {/* <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '250px', backgroundColor: '#fff' }}>
                Content of first tab
                <Button>aaaaaa</Button>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '250px', backgroundColor: '#fff' }}>
                Content of second tab
              </div>
              <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '250px', backgroundColor: '#fff' }}>
                Content of third tab
              </div> */}
            </Tabs>
          </div>
        </div>
    </div>
  );
}

export default BusList;