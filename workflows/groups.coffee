demo = !!~location.hostname.indexOf 'demo'
beta = !!~location.pathname.indexOf 'beta'
preview = !!~location.hostname.indexOf 'preview'
highPort = +location.port >= 1024

dev = demo || beta || preview || highPort
if dev
  module.exports =
    batch1: '5523e3577b9f994c14000001'
    batch2: '5523e3577b9f994c14000003'
    field: 'field'
else
  module.exports =
    batch1: '5527dc1fea4cd10469000001'
    batch2: '5527dc1fea4cd10469000003'
    field: 'TODO'
  