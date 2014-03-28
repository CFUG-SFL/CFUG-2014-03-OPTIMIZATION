$(function(){
    var cache       = $('#cache'),
        cachelist   = cache.find('#cache-list');
    // clear clicks
    cache.on('click','button',function(){
    
        var me = $(this);
        
        switch (me.data('role')){
            
            case 'clear':
                me.attr('disabled','disabled').parents('tr').css('opacity','.5');
                 $.ajax('./',{
                    data    : {id : me.data('id'), act:'remove'},
                    type    : 'POST',
                    success : function(response){
                        if(response.success === true){
                            me.parents('tr').remove();
                            if( cachelist.find('tbody td').length === 0){
                                cachelist.after('<div class="alert alert-warning text-center">Your cache is currently empty.</div>');
                                cachelist.remove();
                                cache.find('button[data-role="clear-all"]').remove();
                            }
                        } else {
                            me.removeAttr('disabled').parents('tr').css('opacity','1');
                        }
                    }
                });
            break;
            
            case 'clear-all':
                cachelist.css('opacity','.5');
                $.ajax('./',{
                    data    : {act:'remove_all'},
                    type    : 'POST',
                    success : function(response){
                        if(response.success === true){
                            cachelist.after('<div class="alert alert-warning text-center">Your cache is currently empty.</div>');
                            cachelist.remove();
                            me.remove();
                        } else {
                            cachelist.css('opacity','1');
                        }
                    }
                });
            break;
            
            case 'reinit':
                $.ajax('./',{
                    data    : {act:'remove_all'},
                    type    : 'POST',
                    success : function(response){
                        window.location = window.location.pathname + '?reinit=1';
                    }
                });
            break;        
            
        }
        return false;
    });
});