$("#spinner_<%=@parameter.resource_id%>").hide();

$('#resource_params_<%=@parameter.resource_id%>').prepend('

<% if @parameter.paramstyle == "header" %>
	<b>Header</b>: <%=@parameter.paramname%> = <%=@parameter.paramdefault%>
	<br /><%=@parameter.description%>
<% end %>
<% if @parameter.paramstyle == "query" %>
	<b>Parameter</b>: <%=@parameter.paramname%> = 
	<% if @parameter.paramdefault.blank? %>
		{string}
	<% else %>
		<%=@parameter.paramdefault %>
	<% end %>
	<br /><%=@parameter.description%>
<% end %>
<% if !@parameter.payload.blank?  %>
	<b>Payload</b>: <%=@parameter.payload%>
<% end %>
<% if @parameter.paramrequired  %>
	<b>* required</b>
<% end %>
') 
.hide()
.fadeIn()

$("#addparameter_<%=@parameter.resource_id%>").hide();




