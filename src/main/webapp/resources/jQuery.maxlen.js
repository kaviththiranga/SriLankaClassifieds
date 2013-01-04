jQuery.fn.maxlength = function(){
     
    $("textarea[@maxlength]").keypress(function(event){
        var key = event.which;
         
        //all keys including return.
        if(key >= 33 || key == 13) {
            var maxLength = $(this).attr("maxlength");
            var length = this.value.length;
            if(length >= maxLength) {
                 
                event.preventDefault();
            }
        }
    });
}