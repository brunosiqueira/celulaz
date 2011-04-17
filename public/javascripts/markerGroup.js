
function GMarkerGroup(active,markers,markersById){this.active=active;this.markers=markers||new Array();this.markersById=markersById||new Object();}
GMarkerGroup.prototype=new GOverlay();GMarkerGroup.prototype.initialize=function(map){this.map=map;if(this.active){for(var i=0,len=this.markers.length;i<len;i++){this.map.addOverlay(this.markers[i]);}
for(var id in this.markersById){this.map.addOverlay(this.markersById[id]);}}}
GMarkerGroup.prototype.remove=function(){this.deactivate();}
GMarkerGroup.prototype.redraw=function(force){}
GMarkerGroup.prototype.copy=function(){var overlay=new GMarkerGroup(this.active);overlay.markers=this.markers;overlay.markersById=this.markersById;return overlay;}
GMarkerGroup.prototype.clear=function(){this.deactivate();this.markers=new Array();this.markersById=new Object();}
GMarkerGroup.prototype.addMarker=function(marker,id){if(id==undefined){this.markers.push(marker);}else{this.markersById[id]=marker;}
if(this.active&&this.map!=undefined){this.map.addOverlay(marker);}}
GMarkerGroup.prototype.showMarker=function(id){var marker=this.markersById[id];if(marker!=undefined){GEvent.trigger(marker,"click");}}
GMarkerGroup.prototype.activate=function(active){active=(active==undefined)?true:active;if(!active){if(this.active){if(this.map!=undefined){for(var i=0,len=this.markers.length;i<len;i++){this.map.removeOverlay(this.markers[i])}
for(var id in this.markersById){this.map.removeOverlay(this.markersById[id]);}}
this.active=false;}}else{if(!this.active){if(this.map!=undefined){for(var i=0,len=this.markers.length;i<len;i++){this.map.addOverlay(this.markers[i]);}
for(var id in this.markersById){this.map.addOverlay(this.markersById[id]);}}
this.active=true;}}}
GMarkerGroup.prototype.centerAndZoomOnMarkers=function(){if(this.map!=undefined){var tmpMarkers=this.markers.slice();for(var id in this.markersById){tmpMarkers.push(this.markersById[id]);}
if(tmpMarkers.length>0){this.map.centerAndZoomOnMarkers(tmpMarkers);}}}
GMarkerGroup.prototype.deactivate=function(){this.activate(false);}