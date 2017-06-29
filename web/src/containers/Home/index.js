import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { css, StyleSheet } from 'aphrodite';
import { fetchRooms, createRoom, joinRoom } from '../../actions/rooms';
import NewRoomForm from '../../components/NewRoomForm';
import Navbar from '../../components/Navbar';
import RoomListItem from '../../components/RoomListItem';

const styles = StyleSheet.create({
  card: {
    maxWidth: '500px',
    padding: '3rem 4rem',
    margin: '2rem auto',
  },
});

class Home extends Component {
  constructor(props) {
    super(props);
    this.handleNewRoomSubmit = this.handleNewRoomSubmit.bind(this);
    this.handleRoomJoin = this.handleRoomJoin.bind(this);
    this.renderRooms = this.renderRooms.bind(this);
  }
  componentDidMount() {
    this.props.fetchRooms();
  }

  handleNewRoomSubmit(data) {
    this.props.createRoom(data, this.context.router);
  }

  handleRoomJoin(roomId) {
    this.props.joinRoom(roomId, this.context.router);
  }

  renderRooms() {
    const currentUserRoomIds = [];
    this.props.currentUserRooms.map(room => currentUserRoomIds.push(room.id));

    return this.props.rooms.map(room =>
      <RoomListItem
        key={room.id}
        room={room}
        onRoomJoin={this.handleRoomJoin}
        currentUserRoomIds={currentUserRoomIds}
      />
    );
  }

  render() {
    return (
      <div style={{ flex: '1' }}>
        <Navbar />
        <div className={`card ${css(styles.card)}`}>
          <h3 style={{ marginBottom: '2rem', textAlign: 'center' }}>Create a new room</h3>
          <NewRoomForm onSubmit={this.handleNewRoomSubmit} />
        </div>
        <div className={`card ${css(styles.card)}`}>
          <h3 style={{ marginBottom: '2rem', textAlign: 'center' }}>Join a room</h3>
          {this.renderRooms()}
        </div>
      </div>
    );
  }
}

Home.contextTypes = {
  router: PropTypes.object
};

Home.propTypes = {
  logout: PropTypes.func,
  currentUser: PropTypes.object,
  isAuthenticated: PropTypes.bool,
  rooms: PropTypes.array,
  currentUserRooms: PropTypes.array,
  fetchRooms: PropTypes.func,
  createRoom: PropTypes.func,
  joinRoom: PropTypes.func,
};

export default connect(
  state => ({
    rooms: state.rooms.all,
    currentUserRooms: state.rooms.currentUserRooms,
  }),
  { fetchRooms, createRoom, joinRoom }
)(Home);



// import React, { Component } from 'react';
// import PropTypes from 'prop-types';
// import { connect } from 'react-redux';
// import { Link } from 'react-router';
// import { logout } from '../../actions/session';
// import Navbar from '../../components/Navbar';
//
// class Home extends Component {
//   constructor(props) {
//     super(props);
//     this.handleLogout = this.handleLogout.bind(this);
//   }
//
//   handleLogout() {
//     this.props.logout(this.context.router);
//   }
//
//   render() {
//     const { currentUser, isAuthenticated } = this.props;
//
//     return (
//       <div style={{ flex: '1' }}>
//         <Navbar />
//         <ul>
//           <li><Link to="/login">Login</Link></li>
//           <li><Link to="/signup">Signup</Link></li>
//         </ul>
//         {isAuthenticated &&
//           <div>
//             <span>{currentUser.username}</span>
//             <button type="button" onClick={this.handleLogout}>Logout</button>
//           </div>
//         }
//       </div>
//     );
//   }
// }
//
// Home.contextTypes = {
//   router: PropTypes.object
// };
//
// Home.propTypes = {
//   logout: PropTypes.func,
//   currentUser: PropTypes.object,
//   isAuthenticated: PropTypes.bool,
// };
//
// export default connect(
//   state => ({
//     isAuthenticated: state.session.isAuthenticated,
//     currentUser: state.session.currentUser,
//   }),
//   { logout }
// )(Home);
