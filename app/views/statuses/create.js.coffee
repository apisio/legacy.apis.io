$("#spinner").hide();
$('#status_input_box').val('').focus();
$('#counter_box').text('140');

setbuttonclick();

$('#statuses').prepend('
<div class="bubble" id="temp">
<% if session["image"] %>	
<img src="<%= session["image"] rescue "" %>" style="width:100px; height: 100px;" align="left"/>
<% else %>
<%= gravatar_image_tag session["email"], :class => "gravatar", :align => "left" rescue "" %>
<% end %>
<blockquote><p> <%=@status.message.gsub("'", "") rescue "" %></p></blockquote><cite>
<a href="/<%= session["username"] rescue ""%>">
<%= session["username"].upcase rescue ""%></a> 
Updated <%= time_ago_in_words @status.created_at rescue ""%> ago</cite>
</div>') 
.hide()
.fadeIn()



