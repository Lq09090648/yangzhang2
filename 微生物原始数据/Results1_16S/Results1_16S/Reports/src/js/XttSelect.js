function XttSelect(id){
    this.id=id;
    this.element=$(id);
}
XttSelect.prototype.xttchange=function(){
    var that=this.element;
    var id=this.id;
    that.live("change",function(){
      var myValue=$(this).val();
      var myLength=$(id).find("option").size();
      for(var i=1;i<myLength+1;i++){
        $("#"+$(id).find("option").eq(i-1).attr("value")).css({
            "display":"none",
            "overflow":"auto"
        });
      }
      $("#"+myValue).css({
            "display":"block",
            "overflow":"auto"
        });
    })
}