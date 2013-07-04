<%@page contentType="text/html"%><%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Statistiques</title>
        <%@include file="includes/header.jsp" %>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="http://code.highcharts.com/highcharts.js"></script>
    </head>
    <body>
        <%@include file="includes/menu.jsp" %> 
        <div class="statistique">
            <h2>Statistiques</h2>
            <div class="row-fluid">
                <div class="span12">
                    <html:errors/>
                </div>
            </div>
            <div class="row-fluid">                
                <div class="span12">
                    <ul class="nav nav-tabs" id="stats">
                        <li class="active"><a href="#salaire">Salaire</a></li>
                        <li><a href="#competence">Compétences</a></li>
                        <li><a href="#contrat">Contrat</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="salaire">
                            <logic:present name="salaireEmbauche">
                                <bean:size id="size" name="contrats"/>
                                <logic:equal name="size" value="0">
                                    <b>Aucune moyenne possible</b>
                                </logic:equal>
                                <logic:greaterThan name="size" value="0">
                                    <div id="salaires" style="width:100%; height:400px;"></div>
                                    <script>
                                        var colors = Highcharts.getOptions().colors,
                                        categories = ['Salaire moyen à l\'embauche', 'Salaire moyen actuel'],
                                        name = 'Salaires',
                                        data = [{
                                                y: <bean:write name="salaireEmbauche"/>,
                                                color: colors[0]
                                            }, {
                                                y: <bean:write name="salaireActuel"/>,
                                                color: colors[1]
                                            },];                                
    
                                        var chart = $('#salaires').highcharts({
                                            chart: {
                                                type: 'column'
                                            },
                                            title: {
                                                text: 'Salaires des Alumnis'
                                            },
                                            xAxis: {
                                                categories: categories
                                            },
                                            yAxis: {
                                                title: ''
                                            },
                                            plotOptions: {
                                                column: {
                                                    cursor: 'pointer',
                                                    dataLabels: {
                                                        enabled: true,
                                                        color: colors[0],
                                                        style: {
                                                            fontWeight: 'bold'
                                                        },
                                                        formatter: function() {
                                                            return this.y +' €';
                                                        }
                                                    }
                                                }
                                            },
                                            tooltip: {
                                                formatter: function() {
                                                    var point = this.point,
                                                    s = this.x +':<b>'+ this.y +' €';
                                                    return s;
                                                }
                                            },
                                            series: [{
                                                    name: name,
                                                    data: data,
                                                    color: 'white'
                                                }],
                                            exporting: {
                                                enabled: false
                                            }
                                        })
                                        .highcharts(); // return chart
                                    </script>
                                </logic:greaterThan>
                            </logic:present>                           
                        </div>
                        <div class="tab-pane" id="competence">                                  
                            <logic:present name="competences">
                                <bean:size id="size" name="competences"/>
                                <logic:equal name="size" value="0">
                                    <b>
                                        Aucune(s) compétence(s)
                                    </b>
                                </logic:equal>
                                <logic:greaterThan name="size" value="0">
                                    <div id="competences" style="width:100%; height:400px;"></div>
                                    <script>
                                        $('#competences').highcharts({
                                            chart: {
                                                plotBackgroundColor: null,
                                                plotBorderWidth: null,
                                                plotShadow: false
                                            },
                                            title: {
                                                text: 'Répartition des compétences'
                                            },
                                            tooltip: {
                                                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                                            },
                                            plotOptions: {
                                                pie: {
                                                    allowPointSelect: true,
                                                    cursor: 'pointer',
                                                    dataLabels: {
                                                        enabled: true,
                                                        color: '#000000',
                                                        connectorColor: '#000000',
                                                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                                                    }
                                                }
                                            },
                                            series: [{
                                                    type: 'pie',
                                                    name: 'Browser share',
                                                    data: [
                                        <logic:iterate id="competence" name="competences">
                                                            ['<bean:write name="competence" property="key"/>',
                                            <bean:write name="competence" property="value"/>],
                                        </logic:iterate>
                                                            ]
                                                        }]
                                                });
                                    </script>
                                </logic:greaterThan>
                            </logic:present>
                        </div>

                        <div class="tab-pane" id="contrat">
                            <div class="row-fluid">
                                <div class="span4">
                                    <logic:present name="contrats">
                                        <bean:size id="size" name="contrats"/>
                                        <logic:equal name="size" value="0">
                                            <b>
                                                Aucun(s) contrat(s)
                                            </b>
                                        </logic:equal>
                                        <logic:greaterThan name="size" value="0">
                                            <div id="contratTout" style="width:21%; height:250px;"></div>
                                    <script>
                                            $('#contratTout').highcharts({
                                                chart: {
                                                    plotBackgroundColor: null,
                                                    plotBorderWidth: null,
                                                    plotShadow: false
                                                },
                                                title: {
                                                    text: 'Général'
                                                },
                                                tooltip: {
                                                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                                                },
                                                plotOptions: {
                                                    pie: {
                                                        allowPointSelect: true,
                                                        cursor: 'pointer',
                                                        dataLabels: {
                                                            enabled: true,
                                                            color: '#000000',
                                                            connectorColor: '#000000',
                                                            format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                                                        }
                                                    }
                                                },
                                                series: [{
                                                        type: 'pie',
                                                        name: 'Ratio',
                                                        data: [
                                                            <logic:iterate id="contrat" name="contrats">
                                                                ['<bean:write name="contrat" property="key"/>',
                                                                <bean:write name="contrat" property="value"/>],
                                                            </logic:iterate>
                                                        ]
                                                    }]
                                            });
                                    </script>
                                        </logic:greaterThan>
                                    </logic:present>
                                </div>
                                <div class="span4">
                                    <logic:present name="firstContrats">
                                        <bean:size id="size" name="firstContrats"/>
                                        <logic:equal name="size" value="0">
                                            <b>
                                                Aucun(s) contrat(s)
                                            </b>
                                        </logic:equal>
                                        <logic:greaterThan name="size" value="0">
                                            <div id="contratp" style="width:21%; height:250px;"></div>
                                    <script>
                                            $('#contratp').highcharts({
                                                chart: {
                                                    plotBackgroundColor: null,
                                                    plotBorderWidth: null,
                                                    plotShadow: false
                                                },
                                                title: {
                                                    text: '1er Contrat'
                                                },
                                                tooltip: {
                                                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                                                },
                                                plotOptions: {
                                                    pie: {
                                                        allowPointSelect: true,
                                                        cursor: 'pointer',
                                                        dataLabels: {
                                                            enabled: true,
                                                            color: '#000000',
                                                            connectorColor: '#000000',
                                                            format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                                                        }
                                                    }
                                                },
                                                series: [{
                                                        type: 'pie',
                                                        name: 'Ratio',
                                                        data: [
                                                            <logic:iterate id="firstContrat" name="firstContrats">
                                                                ['<bean:write name="firstContrat" property="key"/>',
                                                                <bean:write name="firstContrat" property="value"/>],
                                                            </logic:iterate>
                                                        ]
                                                    }]
                                            });
                                    </script>
                                        </logic:greaterThan>
                                    </logic:present>
                                </div>
                                <div class="span4">
                                    <logic:present name="lastContrats">
                                        <bean:size id="size" name="lastContrats"/>
                                        <logic:equal name="size" value="0">
                                            <b>
                                                Aucun(s) contrat(s)
                                            </b>
                                        </logic:equal>
                                        <logic:greaterThan name="size" value="0">
                                            <div id="contratl" style="width:21%; height:250px;"></div>
                                    <script>
                                            $('#contratl').highcharts({
                                                chart: {
                                                    plotBackgroundColor: null,
                                                    plotBorderWidth: null,
                                                    plotShadow: false
                                                },
                                                title: {
                                                    text: 'À date'
                                                },
                                                tooltip: {
                                                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                                                },
                                                plotOptions: {
                                                    pie: {
                                                        allowPointSelect: true,
                                                        cursor: 'pointer',
                                                        dataLabels: {
                                                            enabled: true,
                                                            color: '#000000',
                                                            connectorColor: '#000000',
                                                            format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                                                        }
                                                    }
                                                },
                                                series: [{
                                                        type: 'pie',
                                                        name: 'Ratio',
                                                        data: [
                                                            <logic:iterate id="lastContrat" name="lastContrats">
                                                                ['<bean:write name="lastContrat" property="key"/>',
                                                                <bean:write name="lastContrat" property="value"/>],
                                                            </logic:iterate>
                                                        ]
                                                    }]
                                            });
                                    </script>
                                        </logic:greaterThan>
                                    </logic:present>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="includes/footer.jsp" %> 

            <script src="js/bootstrap.min.js"></script>
            <script>
                    $('#stats a').click(function(e) {
                        e.preventDefault();
                        $(this).tab('show');
                    })
            </script>

    </body>
</html>