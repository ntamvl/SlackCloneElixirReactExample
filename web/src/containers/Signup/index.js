import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { signup } from '../../actions/session';
import SignupForm from '../../components/SignupForm';
import Navbar from '../../components/Navbar';

class Signup extends Component {

  handleSignup(data) {
    this.props.signup(data, this.context.router);
  }

  render() {
    return (
      <div style={{ flex: '1' }}>
        <Navbar />
        <SignupForm onSubmit={this.handleSignup} />
      </div>
    );
  }
}

Signup.contextTypes = {
  router: PropTypes.object
};

Signup.propTypes = {
  signup: PropTypes.func
};

export default connect(null, { signup })(Signup);
