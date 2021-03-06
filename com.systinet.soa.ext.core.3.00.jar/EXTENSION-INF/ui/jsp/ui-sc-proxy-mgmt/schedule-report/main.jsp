var buildReportView=function(reportData) {

    var Report = Ext.data.Record.create([
                {
                  name: 'name',
                  type: 'string'
                },
                {
                  name: 'description',
                  type: 'string'
                },
                {
                  name: 'log',
                  type: 'string'
                },
                {
                  name: 'date',
                  type: 'date',
                  convert: function(v,record)
                  {
                     return new Date(v);
                  }
                },
                {
                  name: 'type',
                  type: 'string'
                },
                {
                  name: 'id',
                  type: 'integer'
                }
    ]);

    var expander = new Ext.ux.grid.RowExpander({
                    tpl : new Ext.XTemplate(
                        '<div style="margin-left:4px;">',
                            '<span style="font-size:12px">{log}</span>',
                        '</div>'
                    )
    });


    var reportSelectionModel=new Ext.grid.CheckboxSelectionModel();
    var reportStore = new Ext.data.Store({
       autoDestroy: true,
       reader: new Ext.data.JsonReader({fields: Report,  root: 'records'  }),
       data: { records : reportData.result },
       sortInfo: {field: 'date', direction: 'DESC'}
    });
/*
    var reportStore = new Ext.data.GroupingStore({
         autoDestroy: true,
         groupField:'deviceName',
         reader: new Ext.data.JsonReader({fields: Report,  root: 'records'  }),
         sortInfo: {field: 'name', direction: 'ASC'},
         data: { records : reportData.results }
    });*/

    var reportGrid = new Ext.grid.GridPanel({
        store: reportStore,
        width: 'auto',
        height:800,
        region:'center',
        margins: '0 5 5 5',
        emptyText: 'No results to display',
        autoExpandColumn: 'name',
        selModel: reportSelectionModel,
        plugins: [expander],/*
        view: new Ext.grid.GroupingView({
                    markDirty: true
        }),*/
        columns: [
                expander,
                {
                    id: 'name',
                    header: 'Name',
                    dataIndex: 'name',
                    width: 150,
                    sortable: true
                },{
                    header: 'Type',
                    dataIndex: 'type',
                    hidden: false,
                    width: 70,
                    sortable: true
                },{
                    id: 'date',
                    header: 'Date',
                    dataIndex: 'date',
                    hidden: false,
                    renderer: function(date) { return date.format("Y/m/d H:i") },
                    width: 110,
                    sortable: true
                },{
                    id: 'description',
                    header: 'Description',
                    dataIndex: 'description',
                    hidden: true,
                    width: 200,
                    sortable: true
                },
                reportSelectionModel
        ]
    });

    var confirmSyncCompletion=function(result)
    {
            Ext.Msg.show({
              title:'Info..',
              msg: 'Reports(s) deleted',
              minWidth:800,
              multiline: true,
              value:result.results.join('\n'),
              fn:function() {
                window.location.reload();
              },
              buttons: Ext.Msg.OK,
              icon: Ext.MessageBox.INFO
            });
    }

    var deleteReportsHandler=function(taskKey)
    {
        monitorProgress(taskKey,confirmSyncCompletion,'Deleting reports ..');
    };

    var buildReportListForProcessing=function(records)
    {
       var toSynchronize=new Array();
       for(i=0;i<records.length;i++)
       {
          toSynchronize[i]={ id:records[i].data.id };
       }
       return toSynchronize;
    }


    var onDeleteReportsClick=function()
    {
       var records=reportSelectionModel.getSelections();
       var toSynchronize=buildReportListForProcessing(records);
       deleteReports(Ext.encode(toSynchronize),deleteReportsHandler);
    }


    var deleteSelectedReportsButton = new Ext.Button({
            text: 'Delete From Repository',
            listeners: { click: onDeleteReportsClick },
            disabled:true
    });

    reportSelectionModel.on('selectionchange',function(model) { deleteSelectedReportsButton.setDisabled(model.getCount()==0);} );

    win = new Ext.Window({
       title       : 'Proxy Validation Reports',
       layout      : 'fit',
       width       : 860,
       height      : calculateWindowHeight(785),
       modal       : true,
       closeAction : 'destroy',
       plain       : true,
       maximizable : true,
       bodyStyle   : 'padding:0',
       items       : reportGrid,
       buttons     : [ deleteSelectedReportsButton, new Ext.Button({ text: 'Close', listeners: {click:function() {win.destroy();} } }) ]
    });

    win.show();
};

var dataLoadedHandler=function(taskKey)
{
    monitorProgress(taskKey,buildReportView,'Loading data ..');
};

Ext.onReady(function() {
  validationReport(dataLoadedHandler);
});
