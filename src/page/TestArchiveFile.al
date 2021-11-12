/// <summary>
/// Page TestArchiveFile (ID 50101).
/// </summary>
page 50101 TestArchiveFile
{
    ApplicationArea = Basic, Suite;
    Caption = 'Test Archive File';
    PageType = Card;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionExportTextFile)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export Text File';
                Image = Text;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    cduArchiveFile.ExportTextFile();
                end;
            }

            action(ActionExportPdfFile)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export Pdf File';
                Image = SendAsPDF;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    cduArchiveFile.ExportPdfFile();
                end;
            }

            action(ActionExportPdfFileWithFilters)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export Pdf File With Filters';
                Image = SendEmailPDFNoAttach;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    cduArchiveFile.ExportPdfFileWithFilters();
                end;
            }

            action(ActionExportPdfFileWithParams)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export Pdf File With Params';
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    cduArchiveFile.ExportPdfFileWithParams();
                end;
            }

            action(ActionExportXmlFile)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export Xml File';
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    cduArchiveFile.ExportXmlFile();
                end;
            }
        }
    }

    var
        cduArchiveFile: Codeunit "Test Archive File";
}