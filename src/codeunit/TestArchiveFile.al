/// <summary>
/// Codeunit MyTestCodeunit (ID 50000).
/// </summary>
codeunit 50100 "Test Archive File"
{
    trigger OnRun()
    begin
        //ExportTextFile();
        //ExportXmlFile();
        //ExportPdfFile();
    end;

    /// <summary>
    /// ExportTextFile.
    /// </summary>
    procedure ExportTextFile()
    var
        BLine: Text;
    begin
        FileTextLine := '';
        BLine := BreakLineText();
        TempBlob.CreateOutStream(OStream);

        Customer.Reset();
        if Customer.FindSet() then
            repeat
                //FileTextLine := 'Customer: ' + Customer."No." + ' ' + Customer.Name + BLine;
                //AppendOutStreamText(OStream, FileTextLine);
                FileTextLine := 'Customer: ' + Customer."No." + ' ' + Customer.Name;
                AppendOutStreamTextLine(OStream, FileTextLine);
            until Customer.Next() = 0;

        FileMgt.BLOBExport(TempBlob, 'CustomerList.txt', true);
    end;

    /// <summary>
    /// ExportPdfFile.
    /// </summary>
    procedure ExportPdfFile()
    begin
        TempBlob.CreateOutStream(OStream);

        //Clear(CustomerList);
        //CustomerList.SaveAs('', ReportFormat::Pdf, OStream);
        Report.SaveAs(Report::"Customer - List", '', ReportFormat::Pdf, OStream);

        FileMgt.BLOBExport(TempBlob, 'CustomerList.pdf', true);
    end;

    /// <summary>
    /// ExportPdfFileWithFilters.
    /// </summary>
    procedure ExportPdfFileWithFilters()
    begin
        RecRef.Open(Database::"Customer");
        RefField := RecRef.Field(1);
        RefField.SetFilter('01121212|01905893|10000');
        if RecRef.FindSet() then;

        TempBlob.CreateOutStream(OStream);

        //Clear(CustomerList);
        //CustomerList.SaveAs('', ReportFormat::Pdf, OStream, RecRef);
        Report.SaveAs(Report::"Customer - List", '', ReportFormat::Pdf, OStream, RecRef);

        FileMgt.BLOBExport(TempBlob, 'CustomerListWithFilters.pdf', true);
    end;

    /// <summary>
    /// ExportPdfFileWithParams.
    /// </summary>
    procedure ExportPdfFileWithParams()
    var
        RequestParams: Text;
    begin
        RequestParams := BuildRequestPage();
        //Message(RequestParams);
        //exit;

        TempBlob.CreateOutStream(OStream);

        //Clear(CustomerList);
        //CustomerList.SaveAs(RequestParams, ReportFormat::Pdf, OStream);
        Report.SaveAs(Report::"Customer - List", RequestParams, ReportFormat::Pdf, OStream);

        FileMgt.BLOBExport(TempBlob, 'CustomerListWithParams.pdf', true);
    end;

    /// <summary>
    /// ExportXmlFile.
    /// </summary>
    procedure ExportXmlFile()
    begin
        TempBlob.CreateOutStream(OStream);

        MyXmlport.SetDestination(OStream);
        MyXmlport.Export();

        FileMgt.BLOBExport(TempBlob, 'CuxtomerList.xml', true);
    end;

    local procedure ImportFile()
    begin

    end;

    local procedure AppendOutStreamTextLine(var OStreamFile: OutStream; var TextLine: Text)
    var
        TextAux: text;
    begin
        TextAux := TextLine + BreakLineText();
        OStreamFile.WriteText(TextAux);
    end;

    local procedure AppendOutStreamText(var OStreamFile: OutStream; var TextLine: Text)
    begin
        OStreamFile.WriteText(TextLine);
    end;

    local procedure BreakLineText(): Text
    begin
        d := 10;
        c := d;
        exit(Format(c));
    end;

    local procedure BuildRequestPage(): Text
    var
        XmlWriter: Codeunit XmlWriter;
        ReportParameters: Codeunit "Request Page Parameters Helper";
        XmlParameters: Text;
        BiggestText: BigText;
    begin
        // Open RequestPage From Report 101 and save the values to XmlParameters
        //XmlParameters := Report.RunRequestPage(101);
        //Message(XmlParameters);

        /*
        <?xml version="1.0" standalone="yes"?>
        <ReportParameters name="Customer - List" id="101">
            <DataItems>
                <DataItem name="Customer">VERSION(1) SORTING(Field1) WHERE(Field21=1(EU))</DataItem>
            </DataItems>
        </ReportParameters>
        
        <?xml version="1.0" encoding="utf-16"?>
        <ReportParameters name="Customer - List" id="101">
            <DataItems>
                <DataItem name="Customer">VERSION(1) SORTING(Field1) WHERE(Field21=1(EU))</DataItem>
            </DataItems>
        </ReportParameters>
        */
        Clear(XmlWriter);
        XmlWriter.WriteStartDocument();
        XmlWriter.WriteStartElement('ReportParameters');
        XmlWriter.WriteAttributeString('name', 'Customer - List');
        XmlWriter.WriteAttributeString('id', '101');

        XmlWriter.WriteStartElement('DataItems');
        XmlWriter.WriteStartElement('DataItem');
        XmlWriter.WriteAttributeString('name', 'Customer');
        XmlWriter.WriteString('WHERE(Field21=1(EU))');
        XmlWriter.WriteEndElement();
        XmlWriter.WriteEndElement();

        XmlWriter.WriteEndElement();
        XmlWriter.WriteEndDocument();

        XmlWriter.ToBigText(BiggestText);

        exit(Format(BiggestText));
    end;

    var
        RecRef: RecordRef;
        RefField: FieldRef;
        Customer: Record Customer;
        CustomerList: Report "Customer - List";
        FileMgt: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        TempBlobList: Codeunit "Temp Blob List";
        MyXmlport: XmlPort MyXmlport;
        IStream: InStream;
        OStream: OutStream;
        FileTextLine: Text;
        i: Integer;
        c: Char;
        d: Decimal;

}