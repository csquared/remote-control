$(function(){
  socket = io.connect();

  var restore_to_volume = 50;
  $('#restore').hide()

  //use state to hide play or pause
  // assume pause
  if(rdio_state == 0){
    $('#pause-rdio').hide()
  }else{
    $('#play-rdio').hide()
  }

  if(quicktime_state == 0){
    $('#pause-quicktime').hide()
  }else{
    $('#play-quicktime').hide()
  }

  socket.on('toggle', function(app){
    if(app == 'rdio'){
      $('#pause-rdio, #play-rdio').toggle()
    }else{
      $('.toggle-app[data-app=' + app + ']').toggle()
    }
  })

  socket.on('set-volume', function(text){
    $("#volume").text(text + '%')
    var volume = parseInt(text)
    if(volume == 0){
      $('#restore').show().attr('data-volume', restore_to_volume);
      $('#mute').hide()
    }else{
      $('#restore').hide()
      $('#mute').show()
    }
    restore_to_volume = volume;
    $("#plus").attr('data-volume', volume + 5)
    $("#minus").attr('data-volume', volume - 5)
  })

  $('.toggle-id').click(function(event){
    event.stopPropagation();
    event.preventDefault();
    socket.emit($(this).attr('id'));
  })

  $('.toggle-app').click(function(event){
    event.stopPropagation();
    event.preventDefault();
    socket.emit('toggle', $(this).attr('data-app'));
  })

  $('.volume-trigger').click(function(event){
    event.stopPropagation();
    event.preventDefault();
    socket.emit('volume', $(this).attr('data-volume'));
  })
})
