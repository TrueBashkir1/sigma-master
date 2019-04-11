;InnoSetupVersion=5.1.2
;Design by Paramonov Maxim, MAI - 609, 2012

[Setup]
AppName=Sigma 7.3
AppVerName=Sigma 7.3
DefaultDirName=C:\Program Files\MAI\Sigma7.3
DefaultGroupName=Sigma 7.3
OutputBaseFilename=setup_Sigma7.3
VersionInfoCompany=МАИ каф.609
VersionInfoVersion=7.3.0.0
AppVersion=7.3
AppPublisher=МАИ каф.609
AppContact=МАИ каф.609
Compression=lzma
WizardImageFile=embedded\WizardImage.bmp
WizardSmallImageFile=embedded\WizardSmallImage.bmp

[Files]
Source: "{app}\bin\Sigma32.exe"; DestDir: "{app}\bin"; DestName: "Sigma32.exe"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\SigmaPlotProcessing.plg"; DestDir: "{app}\bin"; DestName: "SigmaPlotProcessing.plg"; Components: "SigmaPlot"; Flags: ignoreversion 
Source: "{app}\Example 1\BOUND.for"; DestDir: "{app}\Example 1"; DestName: "BOUND.for"; Components: "Examples"; Flags: ignoreversion 
Source: "{app}\Example 1\example1.sfm"; DestDir: "{app}\Example 1"; DestName: "example1.sfm"; Components: "Examples"; Flags: ignoreversion 
Source: "{app}\Example 1\example1.spr"; DestDir: "{app}\Example 1"; DestName: "example1.spr"; Components: "Examples"; Flags: ignoreversion 
Source: "{app}\Example 1\FORCE.for"; DestDir: "{app}\Example 1"; DestName: "FORCE.for"; Components: "Examples"; Flags: ignoreversion 
Source: "{app}\Example 2\BOUND.for"; DestDir: "{app}\Example 2"; DestName: "BOUND.for"; Components: "Examples"; Flags: ignoreversion 
Source: "{app}\Example 2\example2.sfm"; DestDir: "{app}\Example 2"; DestName: "example2.sfm"; Components: "Examples"; Flags: ignoreversion 
Source: "{app}\Example 2\example2.spr"; DestDir: "{app}\Example 2"; DestName: "example2.spr"; Components: "Examples"; Flags: ignoreversion 
Source: "{app}\Example 2\FORCE.for"; DestDir: "{app}\Example 2"; DestName: "FORCE.for"; Components: "Examples"; Flags: ignoreversion 
Source: "{app}\Example 3\BOUND.for"; DestDir: "{app}\Example 3"; DestName: "BOUND.for"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Example 3\example3.sfm"; DestDir: "{app}\Example 3"; DestName: "example3.sfm"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Example 3\example3.spr"; DestDir: "{app}\Example 3"; DestName: "example3.spr"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Example 3\FINDNODD.for"; DestDir: "{app}\Example 3"; DestName: "FINDNODD.for"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Example 3\FORCE.for"; DestDir: "{app}\Example 3"; DestName: "FORCE.for"; Components: "main"; Flags: ignoreversion
Source: "{app}\Example 3\GRIDDM.for"; DestDir: "{app}\Example 3"; DestName: "GRIDDM.for"; Components: "main"; Flags: ignoreversion
Source: "{app}\Example 3\zoneelem.dat"; DestDir: "{app}\Example 3"; DestName: "zoneelem.dat"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Example 3\read_me.txt"; DestDir: "{app}\Example 3"; DestName: "read_me.txt"; Components: "main"; Flags: ignoreversion
Source: "{app}\empty_prep\empty.spr"; DestDir: "{app}\empty_prep"; DestName: "empty.spr"; Components: "main"; Flags: ignoreversion 
Source: "{app}\empty_prep\PREPR.for"; DestDir: "{app}\empty_prep"; DestName: "PREPR.for"; Components: "main"; Flags: ignoreversion
Source: "{app}\empty_prep\import.sfm"; DestDir: "{app}\empty_prep"; DestName: "import.sfm"; Components: "main"; Flags: ignoreversion
Source: "{app}\empty_prep\read_me.txt"; DestDir: "{app}\empty_prep"; DestName: "read_me.txt"; Components: "main"; Flags: ignoreversion
Source: "{app}\empty_prep\forces.nodes"; DestDir: "{app}\empty_prep"; DestName: "forces.nodes"; Components: "main"; Flags: ignoreversion
Source: "{app}\empty_prep\bounds.nodes"; DestDir: "{app}\empty_prep"; DestName: "bounds.nodes"; Components: "main"; Flags: ignoreversion
Source: "{app}\empty_prep\prep_griddm.nodes"; DestDir: "{app}\empty_prep"; DestName: "prep_griddm.nodes"; Components: "main"; Flags: ignoreversion
Source: "{app}\empty_prep\prep_griddm.elems"; DestDir: "{app}\empty_prep"; DestName: "prep_griddm.elems"; Components: "main"; Flags: ignoreversion
Source: "{app}\empty_prep\materials.elems"; DestDir: "{app}\empty_prep"; DestName: "materials.elems"; Components: "main"; Flags: ignoreversion
Source: "{app}\empty_sigma\BOUND.for"; DestDir: "{app}\empty_sigma"; DestName: "BOUND.for"; Components: "main"; Flags: ignoreversion 
Source: "{app}\empty_sigma\import.sfm"; DestDir: "{app}\empty_sigma"; DestName: "import.sfm"; Components: "main"; Flags: ignoreversion 
Source: "{app}\empty_sigma\kurs.spr"; DestDir: "{app}\empty_sigma"; DestName: "kurs.spr"; Components: "main"; Flags: ignoreversion 
Source: "{app}\empty_sigma\PREPR.for"; DestDir: "{app}\empty_sigma"; DestName: "PREPR.for"; Components: "main"; Flags: ignoreversion 
Source: "{app}\empty_sigma\FORCE.for"; DestDir: "{app}\empty_sigma"; DestName: "FORCE.for"; Components: "main"; Flags: ignoreversion
Source: "{app}\empty_sigma\read_me.txt"; DestDir: "{app}\empty_sigma"; DestName: "read_me.txt"; Components: "main"; Flags: ignoreversion
Source: "{app}\bin\RupertAlg.plg"; DestDir: "{app}\bin"; DestName: "RupertAlg.plg"; Components: "RupertAlg"; Flags: ignoreversion 
Source: "{app}\bin\MatrixImage.plg"; DestDir: "{app}\bin"; DestName: "MatrixImage.plg"; Components: "MatrixImage"; Flags: ignoreversion 
Source: "{app}\test_normalnie_temp.SNC"; DestDir: "{app}"; Components: "main"; Flags: ignoreversion 
Source: "{app}\test_ravnomernie_1020.SRC"; DestDir: "{app}"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\.sdm"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\acad.dll"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\acad.imp"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\colorer.dat"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\ExportAnsys.plg"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\FormEditor.plg"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\FrontalMethod.exe"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\FrontalMethod.ini"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\import.plg"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\kernel32.lib"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\MatrixImage.plg"; DestDir: "{app}\bin"; DestName: "MatrixImage.plg"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\modules_compile.ini"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\modules_order.ini"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\Nastran.plg"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\Nstrn.dll"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\OVT.CustomControls.dll"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\ProgEditorOld.plg"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\RupertAlg.plg"; DestDir: "{app}\bin"; DestName: "RupertAlg.plg"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\sforms.ini"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\ShowDensity.exe"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\ShowResult.plg"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\Sigma32.exe"; DestDir: "{app}\bin"; DestName: "Sigma32.exe"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\sigma32.ini"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\SigmaPlotProcessing.plg"; DestDir: "{app}\bin"; DestName: "SigmaPlotProcessing.plg"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\sigma_open.plg"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\TextResults.plg"; DestDir: "{app}\bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\About.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\AddFile.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\AlgForm.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\BrowseFolder.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ChooseCalc.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Constants.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ExportNastran.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\FStruct.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ImgForm.dfm"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Main.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\MainForm.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\MainInterface.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\MainParam.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Mak_File.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\MSXML.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\PrnServ.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Prnserv.dfm"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Prnserv.pas"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ProgramForm.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ProjectRunUnit.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\project_config.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\project_order.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ResFunc.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Results.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ResultsArrays.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ResultsArrays.pas"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Run_Result.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Segment.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\SetForm.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\sets.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ShowCells.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ShowMatrixForm.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ShowMovings.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ShowMovings.dfm"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\ShowMovings.pas"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Splash.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\strfunc.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\SysSettings.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\test_generator_conf.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\test_generator_result.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\TProject.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\TSigmaForm.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\TSigmaForm.pas"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\UFortranEdit.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit1.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit10.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit11.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit12.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit12.dfm"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit12.pas"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit13.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit13.dfm"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit2.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit3.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit4.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit5.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit6.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit7.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit8.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\Unit9.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\untLoadPset.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\untLoadPset.dfm"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\UPluginList.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\dcu\WaitForm.dcu"; DestDir: "{app}\bin\dcu"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\change.log"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\config.model.xml"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\config.xml"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\contextMenu.xml"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\doLocalConf.xml"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\langs.model.xml"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\langs.xml"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\license.txt"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\LINEDRAW.TTF"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\notepad++.exe"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\NppHelp.chm"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\readme.txt"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\SciLexer.dll"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\session.xml"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\shortcuts.xml"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\stylers.model.xml"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\stylers.xml"; DestDir: "{app}\bin\notepad"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\docMonitorA.dll"; DestDir: "{app}\bin\notepad\plugins"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\FTP_synchronizeA.dll"; DestDir: "{app}\bin\notepad\plugins"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\LightExplorer.dll"; DestDir: "{app}\bin\notepad\plugins"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\mimeToolsA.dll"; DestDir: "{app}\bin\notepad\plugins"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\NppExec.dll"; DestDir: "{app}\bin\notepad\plugins"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\NppExportA.dll"; DestDir: "{app}\bin\notepad\plugins"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\NppNetNoteA.dll"; DestDir: "{app}\bin\notepad\plugins"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\NppPlugin_ChangeMarkerA.dll"; DestDir: "{app}\bin\notepad\plugins"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\NppTextFXA.dll"; DestDir: "{app}\bin\notepad\plugins"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\SpellChecker.dll"; DestDir: "{app}\bin\notepad\plugins"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\actionscript.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\awk.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\c.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\cpp.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\cs.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\css.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\fortran.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\html.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\java.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\javascript.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\lisp.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\nsis.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\pascal.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\perl.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\php.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\python.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\rc.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\sql.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\tex.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\vb.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\vhdl.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\APIs\xml.xml"; DestDir: "{app}\bin\notepad\plugins\APIs"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\docMonitor.ini"; DestDir: "{app}\bin\notepad\plugins\Config"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\FTP_synchronizeA.ini"; DestDir: "{app}\bin\notepad\plugins\Config"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\NppExec.ini"; DestDir: "{app}\bin\notepad\plugins\Config"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\NppNetNote.ini"; DestDir: "{app}\bin\notepad\plugins\Config"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\NppPlugin_ChangeMarkerA.xml"; DestDir: "{app}\bin\notepad\plugins\Config"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\NppTextFXA.ini"; DestDir: "{app}\bin\notepad\plugins\Config"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\SpellChecker.ini"; DestDir: "{app}\bin\notepad\plugins\Config"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\tidy\AsciiToEBCDIC.bin"; DestDir: "{app}\bin\notepad\plugins\Config\tidy"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\tidy\HTMLTIDY.CFG"; DestDir: "{app}\bin\notepad\plugins\Config\tidy"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\tidy\HTMLTIDY.ERR"; DestDir: "{app}\bin\notepad\plugins\Config\tidy"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\tidy\libTidy.dll"; DestDir: "{app}\bin\notepad\plugins\Config\tidy"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\tidy\TIDYCFG.INI"; DestDir: "{app}\bin\notepad\plugins\Config\tidy"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\tidy\W3C-CSSValidator.htm"; DestDir: "{app}\bin\notepad\plugins\Config\tidy"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\Config\tidy\W3C-HTMLValidator.htm"; DestDir: "{app}\bin\notepad\plugins\Config\tidy"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\doc\FTP_synchonize.ReadMe.txt"; DestDir: "{app}\bin\notepad\plugins\doc"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\doc\NppExec.txt"; DestDir: "{app}\bin\notepad\plugins\doc"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\doc\NppExec_Guide.txt"; DestDir: "{app}\bin\notepad\plugins\doc"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\doc\NppExec_Manual.knt"; DestDir: "{app}\bin\notepad\plugins\doc"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\doc\NppExec_Manual.txt"; DestDir: "{app}\bin\notepad\plugins\doc"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\doc\NppExec_TechInfo.txt"; DestDir: "{app}\bin\notepad\plugins\doc"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\plugins\doc\NPPTextFXdemo.TXT"; DestDir: "{app}\bin\notepad\plugins\doc"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\Black board.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\Choco.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\Deep Black.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\Hello Kitty.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\Mono Industrial.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\Monokai.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\Obsidian.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\Plastic Code Wrap.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\Ruby Blue.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\Twilight.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\Vibrant Ink.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\bin\notepad\themes\vim Dark Blue.xml"; DestDir: "{app}\bin\notepad\themes"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Comparison 1.6\comparsion_source.rar"; DestDir: "{app}\Comparsion 1.6"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Comparison 1.6\Инструкция по работе с comparison.docx"; DestDir: "{app}\Comparison 1.6"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Comparison 1.6\Comparison-1.6.exe"; DestDir: "{app}\Comparison 1.6"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Comparison 1.6\CmpConverter.exe"; DestDir: "{app}\Comparison 1.6"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Help\FAQ.hlp"; DestDir: "{app}\Help"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Help\H.chm"; DestDir: "{app}\Help"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Help\SigmaResults.JNB"; DestDir: "{app}\Help"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Help\TOSPW.for"; DestDir: "{app}\Help"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Help\Описание плагина SigmaPlotProcessing.pdf"; DestDir: "{app}\Help"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Bin\Bscmake.err"; DestDir: "{app}\Msdev\Bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Bin\Bscmake.exe"; DestDir: "{app}\Msdev\Bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Bin\F23232.exe"; DestDir: "{app}\Msdev\Bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Bin\F90com.exe"; DestDir: "{app}\Msdev\Bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Bin\Fl32.exe"; DestDir: "{app}\Msdev\Bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Bin\Link.exe"; DestDir: "{app}\Msdev\Bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Bin\Mspdb40.dll"; DestDir: "{app}\Msdev\Bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Bin\Nmake.err"; DestDir: "{app}\Msdev\Bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Bin\Nmake.exe"; DestDir: "{app}\Msdev\Bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Bin\Rc.exe"; DestDir: "{app}\Msdev\Bin"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Lib\Console.lib"; DestDir: "{app}\Msdev\Lib"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Lib\Kernel32.lib"; DestDir: "{app}\Msdev\Lib"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Lib\Libc.lib"; DestDir: "{app}\Msdev\Lib"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Lib\Libf.lib"; DestDir: "{app}\Msdev\Lib"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Msdev\Lib\Portlib.lib"; DestDir: "{app}\Msdev\Lib"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\BOUND.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\DATA.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\DEGREE.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\DGRIDD.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\ELSLV.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\ESFCT.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\EUSLV.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\FINDNODD.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\FIND_MIN_ANG.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\FNENDD.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\FNROOT.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\FORCE.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\FORMDD.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\GENAU.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\GENQMD.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\GENRCM.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\GET_STAR.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\GRIDDM.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\MAIN.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\SCHEMA.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\MGSDTR.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\PRNTDD.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\QMDMRG.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\QMDQT.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\QMDRCH.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\QMDUPD.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\RCM.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\RCMSLV.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\REGULARIZATION.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\RENMDD.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\ROOTLS.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\STRDD.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\STSM.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\TOSPW.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\PREPR.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion  
Source: "{app}\Source\Source__sort\smbfct.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion  
Source: "{app}\Source\Source__sort\GENKNG.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\GENRZN.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
Source: "{app}\Source\Source__sort\MEMCNT.for"; DestDir: "{app}\Source\Source__sort"; Components: "main"; Flags: ignoreversion 
 
Source: "{app}\VC_Project_bound\bound.cpp"; DestDir: "{app}\VC_Project_bound"; Components: "main"; Flags: ignoreversion 
Source: "{app}\VC_Project_bound\bound.def"; DestDir: "{app}\VC_Project_bound"; Components: "main"; Flags: ignoreversion 
Source: "{app}\VC_Project_bound\bound.ncb"; DestDir: "{app}\VC_Project_bound"; Components: "main"; Flags: ignoreversion 
Source: "{app}\VC_Project_bound\bound.sln"; DestDir: "{app}\VC_Project_bound"; Components: "main"; Flags: ignoreversion 
Source: "{app}\VC_Project_bound\bound.vcproj"; DestDir: "{app}\VC_Project_bound"; Components: "main"; Flags: ignoreversion 
Source: "{app}\VC_Project_bound\stdafx.cpp"; DestDir: "{app}\VC_Project_bound"; Components: "main"; Flags: ignoreversion 
Source: "{app}\VC_Project_bound\stdafx.h"; DestDir: "{app}\VC_Project_bound"; Components: "main"; Flags: ignoreversion 
Source: "{app}\VC_Project_bound\Release\bound.dll"; DestDir: "{app}\VC_Project_bound\Release"; Components: "main"; Flags: ignoreversion 

[Registry]
Root: HKCU; Subkey: "SOFTWARE\MAI.609"; Flags: uninsdeletekey 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0"; ValueName: "OutDir"; ValueType: String; ValueData: "Obj"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0"; ValueName: "SigmaSource"; ValueType: String; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0"; ValueName: "SigmaSourceDLL"; ValueType: String; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0"; ValueName: "FloatFormat"; ValueType: String; ValueData: "0.00"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0"; ValueName: "InputFileName"; ValueType: String; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0"; ValueName: "NastranFile"; ValueType: String; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0"; ValueName: "DelMakReg"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0"; ValueName: "DelObjReg"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0"; ValueName: "DelTmpReg"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0"; ValueName: "CreateBakReg"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0"; ValueName: "CalcModule"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ProgramForm"; ValueName: "Maximized"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ProgramForm"; ValueName: "Top"; ValueType: Dword; ValueData: "$5D"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ProgramForm"; ValueName: "Left"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ProgramForm"; ValueName: "Width"; ValueType: Dword; ValueData: "$258"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ProgramForm"; ValueName: "Height"; ValueType: Dword; ValueData: "$1E0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\SetForm"; ValueName: "Maximized"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\SetForm"; ValueName: "Top"; ValueType: Dword; ValueData: "$5A"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\SetForm"; ValueName: "Left"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\SetForm"; ValueName: "Width"; ValueType: Dword; ValueData: "$258"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\SetForm"; ValueName: "Height"; ValueType: Dword; ValueData: "$1E0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "StressMethod"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "UseBuffer"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "Maximized"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "Top"; ValueType: Dword; ValueData: "$5D"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "Left"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "Width"; ValueType: Dword; ValueData: "$3D4"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "Height"; ValueType: Dword; ValueData: "$1E0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "ColorZero"; ValueType: String; ValueData: "clWhite"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "ColorPlus"; ValueType: String; ValueData: "clRed"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "Force"; ValueType: String; ValueData: "clBlue"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "BackGround"; ValueType: String; ValueData: "clWhite"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "ForceK"; ValueType: Dword; ValueData: "$14"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "ColorMinus"; ValueType: String; ValueData: "clLime"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "ForcePos"; ValueType: Dword; ValueData: "$4"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "UseLegend"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "UseForce"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "UseBound"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "UseNumZone"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "UseNumNode"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\ShowGrafical"; ValueName: "UseLines"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Запуск"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Запуск"; ValueName: "X"; ValueType: Dword; ValueData: "$11B"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Запуск"; ValueName: "Y"; ValueType: Dword; ValueData: "$2"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Запуск"; ValueName: "Visible"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Запуск"; ValueName: "DockSite"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Импорт"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Импорт"; ValueName: "X"; ValueType: Dword; ValueData: "$F7"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Импорт"; ValueName: "Y"; ValueType: Dword; ValueData: "$2"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Импорт"; ValueName: "Visible"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Импорт"; ValueName: "DockSite"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Открытие результатов"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Открытие результатов"; ValueName: "X"; ValueType: Dword; ValueData: "$AF"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Открытие результатов"; ValueName: "Y"; ValueType: Dword; ValueData: "$2"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Открытие результатов"; ValueName: "Visible"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Открытие результатов"; ValueName: "DockSite"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Редактирование"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Редактирование"; ValueName: "X"; ValueType: Dword; ValueData: "$16D"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Редактирование"; ValueName: "Y"; ValueType: Dword; ValueData: "$2"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Редактирование"; ValueName: "Visible"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Редактирование"; ValueName: "DockSite"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Результат"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Результат"; ValueName: "X"; ValueType: Dword; ValueData: "$1BF"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Результат"; ValueName: "Y"; ValueType: Dword; ValueData: "$2"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Результат"; ValueName: "Visible"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Результат"; ValueName: "DockSite"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Сохранить файл отчета"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Сохранить файл отчета"; ValueName: "X"; ValueType: Dword; ValueData: "$B"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Сохранить файл отчета"; ValueName: "Y"; ValueType: Dword; ValueData: "$2"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Сохранить файл отчета"; ValueName: "Visible"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Сохранить файл отчета"; ValueName: "DockSite"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Файл"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Файл"; ValueName: "X"; ValueType: Dword; ValueData: "$2F"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Файл"; ValueName: "Y"; ValueType: Dword; ValueData: "$2"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Файл"; ValueName: "Visible"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Файл"; ValueName: "DockSite"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Экспорт"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Экспорт"; ValueName: "X"; ValueType: Dword; ValueData: "$D3"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Экспорт"; ValueName: "Y"; ValueType: Dword; ValueData: "$2"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Экспорт"; ValueName: "Visible"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\toolbars\Экспорт"; ValueName: "DockSite"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph"; ValueName: "StressMethod"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments"; ValueName: "LoadSegmentF"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments"; ValueName: "SaveSegmentF"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments"; ValueName: "ReDrawAuto"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments"; ValueName: "ReLoadResWhenShow"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseGridEps"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseGrid"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseBuffer"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseForm"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseNodeNum"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseZoneNum"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseResult"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseNodeRes"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseElements"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseShowBound"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseBlockBound"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseBlockNodes"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseBlockINOUT"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\default"; ValueName: "UseINOUTNodes"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseGridEps"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseGrid"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseBuffer"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseForm"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseNodeNum"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseZoneNum"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseResult"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseNodeRes"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseElements"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseShowBound"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseBlockBound"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseBlockNodes"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseBlockINOUT"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\Segments\current"; ValueName: "UseINOUTNodes"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes"; ValueName: "LoadShowForm"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes"; ValueName: "SaveShowForm"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes"; ValueName: "ShowMenuRes"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes"; ValueName: "ReLoadRegShowForm"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes"; ValueName: "LegendTieColorBar"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "UseBuffer"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "Maximized"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "Top"; ValueType: Dword; ValueData: "$5D"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "Left"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "Width"; ValueType: Dword; ValueData: "$438"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "Height"; ValueType: Dword; ValueData: "$334"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "ColorZero"; ValueType: String; ValueData: "clWhite"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "ColorPlus"; ValueType: String; ValueData: "clRed"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "ColorMinus"; ValueType: String; ValueData: "clLime"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "Force"; ValueType: String; ValueData: "clBlue"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "BackGround"; ValueType: String; ValueData: "clWhite"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "ForceK"; ValueType: Dword; ValueData: "$5"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "ForcePos"; ValueType: Dword; ValueData: "$6"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "UseLegend"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "UseForce"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "UseBound"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "UseNumZone"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "UseNumNode"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\current"; ValueName: "UseLines"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "UseBuffer"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "Maximized"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "Top"; ValueType: Dword; ValueData: "$5D"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "Left"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "Width"; ValueType: Dword; ValueData: "$438"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "Height"; ValueType: Dword; ValueData: "$334"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "ColorZero"; ValueType: String; ValueData: "clWhite"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "ColorPlus"; ValueType: String; ValueData: "clWhite"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "ColorMinus"; ValueType: String; ValueData: "clWhite"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "Force"; ValueType: String; ValueData: "clBlue"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "BackGround"; ValueType: String; ValueData: "clWhite"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "ForceK"; ValueType: Dword; ValueData: "$5"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "ForcePos"; ValueType: Dword; ValueData: "$6"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "UseLegend"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "UseForce"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "UseBound"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "UseNumZone"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "UseNumNode"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\ShowRes\default"; ValueName: "UseLines"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings"; ValueName: "AllUseOneSettings"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings"; ValueName: "AllUseDefault"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings"; ValueName: "SaveSysForm"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\default"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\default"; ValueName: "LoadShowForm"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\default"; ValueName: "SaveShowForm"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\default"; ValueName: "ShowMenuRes"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\default"; ValueName: "ReLoadRegShowForm"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\default"; ValueName: "LegendTieColorBar"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\default"; ValueName: "ReDrawAuto"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\default"; ValueName: "ReLoadResWhenShow"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\default"; ValueName: "LoadSegmentF"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\default"; ValueName: "SaveSegmentF"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\current"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\current"; ValueName: "LoadShowForm"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\current"; ValueName: "SaveShowForm"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\current"; ValueName: "ShowMenuRes"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\current"; ValueName: "ReLoadRegShowForm"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\current"; ValueName: "LegendTieColorBar"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\current"; ValueName: "ReDrawAuto"; ValueType: Dword; ValueData: "$1"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\current"; ValueName: "ReLoadResWhenShow"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\current"; ValueName: "LoadSegmentF"; ValueType: Dword; ValueData: "$0"; 
Root: HKCU; Subkey: "SOFTWARE\MAI.609\SIGMA32\3.0\RupertGraph\SysSettings\current"; ValueName: "SaveSegmentF"; ValueType: Dword; ValueData: "$0"; 

[Run]
;Filename: "{app}\bin\Sigma32.exe"; Description: "{cm:LaunchProgram,Sigma 7.3}"; 

[Icons]
Name: "{group}\Sigma 7.3"; Filename: "{app}\bin\Sigma32.exe";
Name: "{app}\Sigma 7.3"; Filename: "{app}\bin\Sigma32.exe"; 
Name: "{group}\{cm:UninstallProgram,Sigma 7.3}"; Filename: "{uninstallexe}"; 
Name: "{userdesktop}\Sigma 7.3"; Filename: "{app}\bin\Sigma32.exe"; WorkingDir: "{app}\bin\"; Tasks: "desktopicon"; 
  
[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; 

[Components]
Name: "main"; Description: "Основные файлы"; Types: "full compact custom"; Flags: "fixed"
Name: "rupertalg"; Description: "Алгоритм Раперта"; Types: "full compact"; 
Name: "matriximage"; Description: "Модуль вывода образа матрицы"; Types: "full compact"; 
Name: "sigmaplot"; Description: "Вывод результатов расчета в SigmaPlot"; Types: "full compact"; 
Name: "examples"; Description: "Примеры"; Types: "full"; 

[Types]
Name: "full"; Description: "Полная установка";
Name: "compact"; Description: "Полная установка без примеров" 
Name: "custom"; Description: "Выборочная установка"; Flags: "iscustom"


[CustomMessages]
rus.NameAndVersion=%1, версия %2
rus.AdditionalIcons=Дополнительные значки:
rus.CreateDesktopIcon=Создать значок на &Рабочем столе
rus.CreateQuickLaunchIcon=Создать значок в &Панели быстрого запуска
rus.ProgramOnTheWeb=Сайт %1 в Интернете
rus.UninstallProgram=Деинсталлировать %1
rus.LaunchProgram=Запустить %1
rus.AssocFileExtension=Св&язать %1 с файлами, имеющими расширение %2
rus.AssocingFileExtension=Связывание %1 с файлами %2...

[Languages]
; These files are stubs
; To achieve better results after recompilation, use the real language files
Name: "rus"; MessagesFile: "embedded\rus.isl"; 
