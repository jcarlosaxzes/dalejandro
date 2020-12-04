<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ErrorPage.aspx.vb" Inherits="pasconcept20.ErrorPage" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

            <script type="text/javascript">
!function(T,l,y){var S=T.location,u="script",k="instrumentationKey",D="ingestionendpoint",C="disableExceptionTracking",E="ai.device.",I="toLowerCase",b="crossOrigin",w="POST",e="appInsightsSDK",t=y.name||"appInsights";(y.name||T[e])&&(T[e]=t);var n=T[t]||function(d){var g=!1,f=!1,m={initialize:!0,queue:[],sv:"4",version:2,config:d};function v(e,t){var n={},a="Browser";return n[E+"id"]=a[I](),n[E+"type"]=a,n["ai.operation.name"]=S&&S.pathname||"_unknown_",n["ai.internal.sdkVersion"]="javascript:snippet_"+(m.sv||m.version),{time:function(){var e=new Date;function t(e){var t=""+e;return 1===t.length&&(t="0"+t),t}return e.getUTCFullYear()+"-"+t(1+e.getUTCMonth())+"-"+t(e.getUTCDate())+"T"+t(e.getUTCHours())+":"+t(e.getUTCMinutes())+":"+t(e.getUTCSeconds())+"."+((e.getUTCMilliseconds()/1e3).toFixed(3)+"").slice(2,5)+"Z"}(),iKey:e,name:"Microsoft.ApplicationInsights."+e.replace(/-/g,"")+"."+t,sampleRate:100,tags:n,data:{baseData:{ver:2}}}}var h=d.url||y.src;if(h){function a(e){var t,n,a,i,r,o,s,c,p,l,u;g=!0,m.queue=[],f||(f=!0,t=h,s=function(){var e={},t=d.connectionString;if(t)for(var n=t.split(";"),a=0;a<n.length;a++){var i=n[a].split("=");2===i.length&&(e[i[0][I]()]=i[1])}if(!e[D]){var r=e.endpointsuffix,o=r?e.location:null;e[D]="https://"+(o?o+".":"")+"dc."+(r||"services.visualstudio.com")}return e}(),c=s[k]||d[k]||"",p=s[D],l=p?p+"/v2/track":config.endpointUrl,(u=[]).push((n="SDK LOAD Failure: Failed to load Application Insights SDK script (See stack for details)",a=t,i=l,(o=(r=v(c,"Exception")).data).baseType="ExceptionData",o.baseData.exceptions=[{typeName:"SDKLoadFailed",message:n.replace(/\./g,"-"),hasFullStack:!1,stack:n+"\nSnippet failed to load ["+a+"] -- Telemetry is disabled\nHelp Link: https://go.microsoft.com/fwlink/?linkid=2128109\nHost: "+(S&&S.pathname||"_unknown_")+"\nEndpoint: "+i,parsedStack:[]}],r)),u.push(function(e,t,n,a){var i=v(c,"Message"),r=i.data;r.baseType="MessageData";var o=r.baseData;return o.message='AI (Internal): 99 message:"'+("SDK LOAD Failure: Failed to load Application Insights SDK script (See stack for details) ("+n+")").replace(/\"/g,"")+'"',o.properties={endpoint:a},i}(0,0,t,l)),function(e,t){if(JSON){var n=T.fetch;if(n&&!y.useXhr)n(t,{method:w,body:JSON.stringify(e),mode:"cors"});else if(XMLHttpRequest){var a=new XMLHttpRequest;a.open(w,t),a.setRequestHeader("Content-type","application/json"),a.send(JSON.stringify(e))}}}(u,l))}function i(e,t){f||setTimeout(function(){!t&&m.core||a()},500)}var e=function(){var n=l.createElement(u);n.src=h;var e=y[b];return!e&&""!==e||"undefined"==n[b]||(n[b]=e),n.onload=i,n.onerror=a,n.onreadystatechange=function(e,t){"loaded"!==n.readyState&&"complete"!==n.readyState||i(0,t)},n}();y.ld<0?l.getElementsByTagName("head")[0].appendChild(e):setTimeout(function(){l.getElementsByTagName(u)[0].parentNode.appendChild(e)},y.ld||0)}try{m.cookie=l.cookie}catch(p){}function t(e){for(;e.length;)!function(t){m[t]=function(){var e=arguments;g||m.queue.push(function(){m[t].apply(m,e)})}}(e.pop())}var n="track",r="TrackPage",o="TrackEvent";t([n+"Event",n+"PageView",n+"Exception",n+"Trace",n+"DependencyData",n+"Metric",n+"PageViewPerformance","start"+r,"stop"+r,"start"+o,"stop"+o,"addTelemetryInitializer","setAuthenticatedUserContext","clearAuthenticatedUserContext","flush"]),m.SeverityLevel={Verbose:0,Information:1,Warning:2,Error:3,Critical:4};var s=(d.extensionConfig||{}).ApplicationInsightsAnalytics||{};if(!0!==d[C]&&!0!==s[C]){method="onerror",t(["_"+method]);var c=T[method];T[method]=function(e,t,n,a,i){var r=c&&c(e,t,n,a,i);return!0!==r&&m["_"+method]({message:e,url:t,lineNumber:n,columnNumber:a,error:i}),r},d.autoExceptionInstrumented=!0}return m}(y.cfg);(T[t]=n).queue&&0===n.queue.length&&n.trackPageView({})}(window,document,{
src: "https://az416426.vo.msecnd.net/scripts/b/ai.2.min.js", // The SDK URL Source
//name: "appInsights", // Global SDK Instance name defaults to "appInsights" when not supplied
//ld: 0, // Defines the load delay (in ms) before attempting to load the sdk. -1 = block page load and add to head. (default) = 0ms load after timeout,
//useXhr: 1, // Use XHR instead of fetch to report failures (if available),
//crossOrigin: "anonymous", // When supplied this will add the provided value as the cross origin attribute on the script tag 
cfg: { // Application Insights Configuration
    instrumentationKey: "78d202c5-fd94-4940-9bc9-816f1301cfbf",
    autoTrackPageVisitTime: true,
    crossOrigin: "anonymous",
    /* ...Other Configuration Options... */
}});
            </script>

    <%-- Favicons and the like --%>
    <link rel="apple-touch-icon" sizes="180x180" href="~/Content/favicons/apple-touch-icon.png" />
    <link rel="icon" type="image/png" sizes="32x32" href="~/Content/favicons/favicon-32x32.png" />
    <link rel="icon" type="image/png" sizes="16x16" href="~/Content/favicons/favicon-16x16.png" />
    <link rel="manifest" href="~/Content/favicons/site.webmanifest" />

    <meta name="DESCRIPTION" content="A web-based application conceived and designed to provide an all-inclusive management tool for architectural and engineering firms who wish to integrate the interaction." />

    <meta name="KEYWORDS" content="pasconcept,saas,online project administration,architectural app,engineering app,project app,time sheet,proposals online,job online,civil app,mechanical app,structural app,
          electrical app,request for proposal, rfp,subconsultant,
          engineering Software,cloud accounting software,billing system,engineering services,A/E online app,A/E online services,Rational Engineering, Lifecycle Manager, engineering data, engineering lifecycle,
          systems engineering, lifecycle data, open architecture,architectural firm,A/E online administration,proposal for architectural,budget for architectural,budeget for engineering,proposal for engineering,
          proposal for A/E,budget for A/E,agreement for architectural, agreement for engineering,contract for engineering,contract for architectural,agreement for engineering,invoice for engineering,
          invoice for architectural,invoice service, invoice online,time sheet for architectural,time sheet for engineering,rfp for architectural,rfp for engineering,rfp for subconsultant" />

    <meta name="KEYWORDS" content="online,saas,architectural,engineering,saas,platform,web browser,site,pasconcept,project,platform,proposals,gaq,saas,notifications,document,account,var,solution" />
    <meta name="AUTHOR" content="PASconcept Team" />
    <meta name="Resource-type" content="Homepage" />
    <meta name="DateCreated" content="Mon, 12 December 2011 12:53:00 GMT+1" />
    <meta name="Revisit-after" content="7 days" />

    <meta name='url' content='https://pasconcept.com/' />
    <meta name='identifier-URL' content='https://pasconcept.com/' />
    <meta name="image" content="https://pasconcept.com/images/logo/pas_horizontal_logo.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>PASconcept. Your complete online platform of Project </title>

    <link href="App_Themes/Estandar/Estandar.css" rel="stylesheet" type="text/css" />
    <%--Bootstrap reference begin--%>
    <%--<link href="~/Content/bootstrap.min.css" rel="stylesheet" />--%>
    <%--Bootstrap reference end--%>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

</head>
<body title="Welcome to PASconcept. Project Administration Services" style="background-color: white">
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <div class="container">

            <div class="row">
                <div class="col-md-5 col-lg-offset-4" style="margin-top: 5em">

                    <asp:Panel ID="pnlLogin" runat="server">
                        <div class="well">

                            <%--<img class="img-thumbnail" src="/images/logopasconcept-index.png"  />--%>
                            <asp:Image runat="server" class="img-thumbnail" ImageUrl="~/Images/logo/pas_horizontal_logo_big.png" Width="100%" />

                            <div class="form-group" style="margin-top: 1em">
                                <h3 style="color: red;">An Error has Occurred</h3>
                                <p>
                                    An unexpected error has occurred on our webapp. The website administrator has been notified.<br />
                                    Please, <a href="Default.aspx">click here </a> to continue with PASconcept
                                </p>
                            </div>

                        </div>
                    </asp:Panel>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 col-lg-offset-5 ">
                    <a href="http://blog.pasconcept.com" target="_blank">Help</a>
                    &nbsp;|&nbsp;
                    <a href="https://pasconcept.com/Legal/ENG/Terms.html" target="_blank">Terms & Conditions</a>
                </div>
            </div>

        </div>

    </form>
</body>
</html>
