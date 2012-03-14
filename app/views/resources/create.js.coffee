$("#spinner").hide();
setbuttonclick();

<%
if @resource.resourcemethod == "GET" 
	btncolor = "primary"
elsif @resource.resourcemethod == "POST" 
	btncolor = "success"
elsif @resource.resourcemethod == "DELETE" 
	btncolor = "danger"
elsif @resource.resourcemethod == "PUT" 
	btncolor = "inverse"
end

if @resource.authentication == "None"
	prefix = ''
else
	prefix = '<i class="icon-lock icon-white"></i>'
end 	
%>

$('#resources').prepend('
<tr class="table table-striped table-bordered">
   <td width="20%"><a class="btn disabled btn-large btn-<%=btncolor%>"><%=raw(prefix)%> <%=@resource.resourcemethod rescue ""%></a></td>
   <td width="80%"><b>/<%=@resource.pathurl rescue ""%></b> - <%=@resource.description rescue ""%> (<a href="<%=@resource.docurl%>">more</a>)<br />
      <code><%= @resource.curlexample rescue ""%></code>
   </td>
</tr>') 
.hide()
.fadeIn()

$("#addbutton").attr('value','Submit');
$("#spinner").hide();
$("#addresource").hide();




