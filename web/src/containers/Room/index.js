import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { connectToChannel, leaveChannel } from '../../actions/room';

class Room extends Component {
  componentDidMount() {
    console.log("Room componentDidMount");
    this.props.connectToChannel(this.props.socket, this.props.params.id);
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.params.id !== this.props.params.id) {
      this.props.leaveChannel(this.props.channel);
      this.props.connectToChannel(nextProps.socket, nextProps.params.id);
    }
    if (!this.props.socket && nextProps.socket) {
      this.props.connectToChannel(nextProps.socket, nextProps.params.id);
    }
  }

  componentWillUnmount() {
    this.props.leaveChannel(this.props.channel);
  }

  render() {
    console.log("currentRoom:");
    console.log(this.props.room);
    return (
      <div>
        <h3>Room chat</h3>
        {this.props.room.name}
      </div>
    );
  }
}

Room.propTypes = {
  socket: PropTypes.object,
  channel: PropTypes.object,
  room: PropTypes.object,
  connectToChannel: PropTypes.func,
  leaveChannel: PropTypes.func,
}

export default connect(
  state => ({
    room: state.room.currentRoom,
    socket: state.session.socket,
    channel: state.room.channel,
  }),
  { connectToChannel, leaveChannel }
)(Room);
