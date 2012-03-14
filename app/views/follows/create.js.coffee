$("#spinner_<%=@followbutton.to_s%>").hide();
$('#followercount').html(<%=@followers%>)

<% if params[:status] == "unfollow" %>

$('#userstatus_<%=@followbutton.to_s%>').html('<form accept-charset="UTF-8" action="/follows?id=<%=params[:id]%>&amp;status=follow" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="q5PZvleStCQT/W3Et0axfGEUndnHyLFdeouxLN1AKLE=" /></div><button name="button" title="Follow <%=@api.name.capitalize%>" type="submit" class="btn" id="follow_<%=@followbutton.to_s%>"><i class="icon-ok"></i> Follow</button></form>')

<% else %>

$('#userstatus_<%=@followbutton.to_s%>').html('<form accept-charset="UTF-8" action="/follows?id=<%=params[:id]%>&amp;status=unfollow" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="q5PZvleStCQT/W3Et0axfGEUndnHyLFdeouxLN1AKLE=" /></div><button name="button" title="Unfollow <%=@api.name.capitalize%>" type="submit" class="btn btn-danger" id="follow_<%=@followbutton.to_s%>"><i class="icon-remove icon-white"></i> Unfollow</button></form>')

<% end %> 

setbuttonclick(<%=@followbutton.to_s%>);
