$("#explorerspinner").hide();
$("#output").show();

$('#apipermalink').html('<a href="/explorers/<%=@ref%>">Request/Response Permalink</a>');

$('#apirequest').html('<pre class="prettyprint linenums"><code><%=raw(@request)%></code></pre>');

$('#apiresponse').html('<pre class="prettyprint linenums"><code><%= raw(@header + "<br />"+  escape_javascript(@body)) %></code></pre>');




