import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { login } from '../../actions/session';
import LoginForm from '../../components/LoginForm';
import Navbar from '../../components/Navbar';

class Login extends Component {

  handleLogin(data) {
    this.props.login(data, this.context.router);
  }

  render() {
    return (
      <div style={{ flex: '1' }}>
        <Navbar />
        <LoginForm onSubmit={this.handleLogin} />
      </div>
    );
  }
}

Login.contextTypes = {
  router: PropTypes.object
};

Login.propTypes = {
  login: PropTypes.func
};

export default connect(null, { login })(Login);
