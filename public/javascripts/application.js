function post_comment(url,show)
{
  var comment_message = $('photo_comment_text').value; // document.forms["login_form"]["login"].value
  if(comment_message == '')
  {
    alert("Comment should not blank");
    return false;
  }
   var state= document.getElementById(show).style.display;

           
   
  
  new Ajax.Request(url,
    { 
      method:'post' ,
      parameters: { comment_name: comment_message},
      onSuccess: function(response) {
	var last_comment = response.responseText ;
        var old_comments = $("all_comment_content").innerHTML;
        $('photo_comment_text').value = '';
        $("all_comment_content").innerHTML = old_comments + last_comment;
      }
    }
  );
  document.getElementById(show).style.display = 'block';
  if (state=='block')
    {
       document.getElementById(show).style.display = 'none'; 
    }
}
function show_comment(show)
        {
    var state= document.getElementById(show).style.display;

       document.getElementById(show).style.display = 'block';    
   
  if (state=='block')
    {
       document.getElementById(show).style.display = 'none'; 
    }
}