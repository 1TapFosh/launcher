procedure WriteInstallId();
begin
  SaveStringToFile(ExpandConstant('{app}\install_id.txt'), IntToStr(Random($7fffffff)), false)
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  rlUpgrade: String;
  exePath: String;
  ResultCode: Integer;
begin
  if CurStep = ssPostInstall then begin
    WriteInstallId();

    rlUpgrade := GetEnv('RUNEFUSION_UPGRADE');
    if rlUpgrade <> '' then begin
      exePath := ExpandConstant('{app}\RuneFusion.exe');
      Exec(exePath, GetEnv('RUNEFUSION_UPGRADE_PARAMS'), '', SW_SHOW, ewNoWait, ResultCode);
    end;
  end;
end;