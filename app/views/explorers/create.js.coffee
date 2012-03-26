$("#spinner").hide();
$("#output").show();

$('#apirequest').html('<pre class="prettyprint linenums"><code><%=raw(@request)%></code></pre>');

$('#apiresponse').html('<pre class="prettyprint linenums"><code><%= raw(@header)%><%= raw(@body)%></code></pre>');




