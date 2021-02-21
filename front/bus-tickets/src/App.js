import React, { Component} from 'react';
import { BrowserRouter, Route } from "react-router-dom";
import BusList from './pages/busList';
import Home from './pages/home';

class App extends Component {
  render() {
    return (
      <div className="App">
        <BrowserRouter>
          <div>
            <Route path="/" exact component={Home}></Route>
            <Route path='/busList' exact component={BusList}></Route>
          </div>
        </BrowserRouter>
      </div>
    );
  }
}

export default App;