class IGPlus_SettingsContent extends UMenuPageWindow;

var ClientSettings Settings;

var UWindowLabelControl Lbl_MoreInformation;
var localized string MoreInformationText;

var UWindowLabelControl Lbl_General;
var localized string GeneralText;

var UWindowCheckbox Chk_ShootDead;
var localized string ShootDeadText;
var localized string ShootDeadHelp;

var UWindowCheckbox Chk_DoEndShot;
var localized string DoEndShotText;
var localized string DoEndShotHelp;

var UWindowCheckbox Chk_UnlitSkins;
var localized string UnlitSkinsText;
var localized string UnlitSkinsHelp;

var UWindowCheckbox Chk_NoOwnFootsteps;
var localized string NoOwnFootstepsText;
var localized string NoOwnFootstepsHelp;

var UWindowCheckbox Chk_ReduceEyeHeightInAir;
var localized string ReduceEyeHeightInAirText;
var localized string ReduceEyeHeightInAirHelp;

var UWindowCheckbox Chk_AllowWeaponShake;
var localized string AllowWeaponShakeText;
var localized string AllowWeaponShakeHelp;

var UWindowCheckbox Chk_AutoReady;
var localized string AutoReadyText;
var localized string AutoReadyHelp;

var UWindowCheckbox Chk_ShowDeathReport;
var localized string ShowDeathReportText;
var localized string ShowDeathReportHelp;

var UWindowCheckbox Chk_SmoothFOVChanges;
var localized string SmoothFOVChangesText;
var localized string SmoothFOVChangesHelp;

var UWindowCheckbox Chk_NoSmoothing;
var localized string NoSmoothingText;
var localized string NoSmoothingHelp;

var UWindowCheckbox Chk_UseOldMouseInput;
var localized string UseOldMouseInputText;
var localized string UseOldMouseInputHelp;

var IGPlus_EditControl Edit_MinDodgeClickTime;
var localized string MinDodgeClickTimeText;
var localized string MinDodgeClickTimeHelp;

var IGPlus_EditControl Edit_DesiredNetUpdateRate;
var localized string DesiredNetUpdateRateText;
var localized string DesiredNetUpdateRateHelp;

var IGPlus_EditControl Edit_DesiredNetspeed;
var localized string DesiredNetspeedText;
var localized string DesiredNetspeedHelp;

var IGPlus_EditControl Edit_FakeCAPInterval;
var localized string FakeCAPIntervalText;
var localized string FakeCAPIntervalHelp;

var UWindowLabelControl Lbl_AutoDemo;
var localized string AutoDemoLblText;

var UWindowCheckbox Chk_AutoDemo;
var localized string AutoDemoText;
var localized string AutoDemoHelp;

var IGPlus_EditControl Edit_DemoMask;
var localized string DemoMaskText;
var localized string DemoMaskHelp;

var IGPlus_EditControl Edit_DemoPath;
var localized string DemoPathText;
var localized string DemoPathHelp;

var IGPlus_EditControl Edit_DemoChar;
var localized string DemoCharText;
var localized string DemoCharHelp;

var UWindowLabelControl Lbl_ForceModels;
var localized string ForceModelsLblText;

var UWindowCheckbox Chk_ForceModels;
var localized string ForceModelsText;
var localized string ForceModelsHelp;

var IGPlus_ComboBox Cmb_DesiredSkin;
var localized string DesiredSkinText;
var localized string DesiredSkinHelp;

var IGPlus_ComboBox Cmb_DesiredSkinFemale;
var localized string DesiredSkinFemaleText;
var localized string DesiredSkinFemaleHelp;

var IGPlus_ComboBox Cmb_DesiredTeamSkin;
var localized string DesiredTeamSkinText;
var localized string DesiredTeamSkinHelp;

var IGPlus_ComboBox Cmb_DesiredTeamSkinFemale;
var localized string DesiredTeamSkinFemaleText;
var localized string DesiredTeamSkinFemaleHelp;

var localized string ForcedModelDefault;
var localized string ForcedModelAphex;
var localized string ForcedModelFemaleCommando;
var localized string ForcedModelFemaleMercenary;
var localized string ForcedModelFemaleNecris;
var localized string ForcedModelFemaleMarine;
var localized string ForcedModelFemaleMetalGuard;
var localized string ForcedModelFemaleSoldier;
var localized string ForcedModelVenom;
var localized string ForcedModelFemaleWarMachine;
var localized string ForcedModelMaleCommando;
var localized string ForcedModelMaleMercenary;
var localized string ForcedModelMaleNecris;
var localized string ForcedModelMaleMarine;
var localized string ForcedModelMaleMetalGuard;
var localized string ForcedModelRawSteel;
var localized string ForcedModelMaleSoldier;
var localized string ForcedModelMaleWarMachine;
var localized string ForcedModelXan;

var UWindowLabelControl Lbl_SuperShockRifle;
var localized string SuperShockRifleText;

var IGPlus_ComboBox Cmb_cShockBeam;
var localized string cShockBeamText;
var localized string cShockBeamHelp;

var localized string cShockBeamDefault;
var localized string cShockBeamTeamColored;
var localized string cShockBeamHidden;
var localized string cShockBeamInstant;

var UWindowCheckbox Chk_HideOwnBeam;
var localized string HideOwnBeamText;
var localized string HideOwnBeamHelp;

var UWindowSmallButton Btn_Close;
var UWindowSmallButton Btn_Save;
var localized string SaveButtonText;
var localized string SaveButtonToolTip;

var float PaddingX;
var float PaddingY;
var float LineSpacing;
var float SeparatorSpacing;
var float ControlOffset;
var bool bLoadSucceeded;

var UWindowDialogControl SettingControls;
var UWindowDialogControl TemporaryControl;

enum EEditControlType {
	ECT_Text,
	ECT_Integer,
	ECT_Real
};

function ClientSettings FindSettingsObject() {
	local bbPlayer P;
	local bbCHSpectator S;

	if (GetPlayerOwner().IsA('bbPlayer') && bbPlayer(GetPlayerOwner()).Settings != none)
		return bbPlayer(GetPlayerOwner()).Settings;

	if (GetPlayerOwner().IsA('bbCHSpectator') && bbCHSpectator(GetPlayerOwner()).Settings != none)
		return bbCHSpectator(GetPlayerOwner()).Settings;

	foreach GetPlayerOwner().AllActors(class'bbPlayer', P)
		if (P.Settings != none)
			return P.Settings;

	foreach GetPlayerOwner().AllActors(class'bbCHSpectator', S)
		if (S.Settings != none)
			return S.Settings;

	return none;
}

function InsertControl(UWindowDialogControl C) {
	if (SettingControls != none)
		C.SetPropertyText("NextSettingControl", string(SettingControls));
	SettingControls = C;
}

function UWindowDialogControl NextControl(UWindowDialogControl C) {
	if (C == none)
		return none;

	SetPropertyText("TemporaryControl", C.GetPropertyText("NextSettingControl"));
	return TemporaryControl;
}

function UWindowCheckbox CreateCheckbox(string T, optional string HT, optional UWindowWindow WndOwner) {
	local UWindowCheckbox Chk;

	Chk = UWindowCheckbox(CreateControl(class'IGPlus_Checkbox', PaddingX, ControlOffset, 200, 1, WndOwner));
	Chk.SetText(T);
	Chk.SetHelpText(HT);
	Chk.ToolTipString = HT;
	Chk.SetFont(F_Normal);
	Chk.Align = TA_Left;
	ControlOffset += LineSpacing;

	InsertControl(Chk);

	return Chk;
}

function IGPlus_EditControl CreateEditResizable(
	EEditControlType ECT,
	string T,
	float EditBoxWidthFraction,
	float EditBoxMinWidth,
	float EditBoxMaxWidth,
	optional string HT,
	optional int MaxLength, // 255 is default
	optional UWindowWindow WndOwner
) {
	local IGPlus_EditControl Edit;

	Edit = IGPlus_EditControl(CreateControl(class'IGPlus_EditControl', PaddingX, ControlOffset, 200, 1, WndOwner));
	Edit.SetText(T);
	Edit.SetHelpText(HT);
	Edit.SetFont(F_Normal);
	Edit.Align = TA_Left;
	if (MaxLength > 0)
		Edit.SetMaxLength(MaxLength);

	Edit.EditBoxWidthFraction = EditBoxWidthFraction;
	Edit.EditBoxMinWidth = EditBoxMinWidth;
	Edit.EditBoxMaxWidth = EditBoxMaxWidth;
	ControlOffset += LineSpacing;

	switch(ECT) {
		case ECT_Text:
			Edit.SetNumericOnly(false);
			Edit.SetNumericOnly(false);
			break;
		case ECT_Integer:
			Edit.SetNumericOnly(true);
			Edit.SetNumericOnly(false);
			break;
		case ECT_Real:
			Edit.SetNumericOnly(true);
			Edit.SetNumericFloat(true);
			break;
	}

	InsertControl(Edit);

	return Edit;
}

function IGPlus_EditControl CreateEdit(
	EEditControlType ECT,
	string T,
	optional string HT,
	optional int MaxLength, // 255 is default
	optional float EditBoxWidth, // 100 is default
	optional UWindowWindow WndOwner
) {
	if (EditBoxWidth <= 0)
		return CreateEditResizable(ECT, T, 0.5, 0, MaxInt, HT, MaxLength, WndOwner);

	return CreateEditResizable(ECT, T, 0.5, EditBoxWidth, EditBoxWidth, HT, MaxLength, WndOwner);
}

function UWindowLabelControl CreateLabel(string T, optional string HT, optional UWindowWindow WndOwner) {
	local UWindowLabelControl Lbl;

	Lbl = UWindowLabelControl(CreateControl(class'IGPlus_Label', PaddingX, ControlOffset, 200, 1, WndOwner));
	Lbl.SetText(T);
	Lbl.SetHelpText(HT);
	Lbl.SetFont(F_Normal);
	Lbl.Align = TA_Left;
	ControlOffset += LineSpacing;

	InsertControl(Lbl);

	return Lbl;
}

function UWindowLabelControl CreateSeparator(string T, optional string HT, optional UWindowWindow WndOwner) {
	local UWindowLabelControl Lbl;

	if (ControlOffset > PaddingY)
		ControlOffset += (SeparatorSpacing - LineSpacing);

	Lbl = UWindowLabelControl(CreateControl(class'IGPlus_Separator', PaddingX, ControlOffset, 200, 1, WndOwner));
	Lbl.SetText(T);
	Lbl.SetHelpText(HT);
	Lbl.SetFont(F_Normal);
	Lbl.Align = TA_Left;
	ControlOffset += LineSpacing;

	InsertControl(Lbl);

	return Lbl;
}

function IGPlus_ComboBox CreateComboBoxResizable(
	string T,
	float EditBoxWidthFraction,
	float EditBoxMinWidth,
	float EditBoxMaxWidth,
	optional string HT,
	optional bool bCanEdit,
	optional UWindowWindow WndOwner
) {
	local IGPlus_ComboBox Cmb;

	EditBoxWidthFraction = FClamp(EditBoxWidthFraction, 0.0, 1.0);

	Cmb = IGPlus_ComboBox(CreateControl(class'IGPlus_ComboBox', PaddingX, ControlOffset, 200, 1, WndOwner));
	Cmb.SetText(T);
	Cmb.SetHelpText(HT);
	Cmb.SetFont(F_Normal);
	Cmb.Align = TA_Left;
	Cmb.SetEditable(bCanEdit);
	Cmb.EditBoxMinWidth = EditBoxMinWidth;
	Cmb.EditBoxMaxWidth = EditBoxMaxWidth;
	Cmb.EditBoxWidthFraction = EditBoxWidthFraction;
	ControlOffset += LineSpacing;

	InsertControl(Cmb);

	return Cmb;
}

function IGPlus_ComboBox CreateComboBox(
	string T,
	optional string HT,
	optional bool bCanEdit,
	optional float EditBoxWidth,
	optional UWindowWindow WndOwner
) {
	if (EditBoxWidth <= 0)
		return CreateComboBoxResizable(T, 0.5, 0, MaxInt, HT, bCanEdit, WndOwner);

	return CreateComboBoxResizable(T, 0.5, EditBoxWidth, EditBoxWidth, HT, bCanEdit, WndOwner);
}

function SetUpForcedModelComboBox(IGPlus_ComboBox Cmb) {
	Cmb.AddItem(ForcedModelDefault);
	Cmb.AddItem(ForcedModelAphex);
	Cmb.AddItem(ForcedModelFemaleCommando);
	Cmb.AddItem(ForcedModelFemaleMercenary);
	Cmb.AddItem(ForcedModelFemaleNecris);
	Cmb.AddItem(ForcedModelFemaleMarine);
	Cmb.AddItem(ForcedModelFemaleMetalGuard);
	Cmb.AddItem(ForcedModelFemaleSoldier);
	Cmb.AddItem(ForcedModelVenom);
	Cmb.AddItem(ForcedModelFemaleWarMachine);
	Cmb.AddItem(ForcedModelMaleCommando);
	Cmb.AddItem(ForcedModelMaleMercenary);
	Cmb.AddItem(ForcedModelMaleNecris);
	Cmb.AddItem(ForcedModelMaleMarine);
	Cmb.AddItem(ForcedModelMaleMetalGuard);
	Cmb.AddItem(ForcedModelRawSteel);
	Cmb.AddItem(ForcedModelMaleSoldier);
	Cmb.AddItem(ForcedModelMaleWarMachine);
	Cmb.AddItem(ForcedModelXan);
}

function Created() {
	local float ControlWidth;

	super.Created();

	ControlOffset = PaddingY;
	ControlWidth = WinWidth - 2*PaddingX;

	Lbl_MoreInformation = CreateLabel(MoreInformationText);
	Lbl_MoreInformation.Align = TA_Center;
	Lbl_MoreInformation.SetFont(F_Bold);

	Lbl_General = CreateSeparator(GeneralText);
	Chk_ShootDead = CreateCheckbox(ShootDeadText, ShootDeadHelp);
	Chk_DoEndShot = CreateCheckbox(DoEndShotText, DoEndShotHelp);
	Chk_UnlitSkins = CreateCheckbox(UnlitSkinsText, UnlitSkinsHelp);
	Chk_NoOwnFootsteps = CreateCheckbox(NoOwnFootstepsText, NoOwnFootstepsHelp);
	Chk_ReduceEyeHeightInAir = CreateCheckbox(ReduceEyeHeightInAirText, ReduceEyeHeightInAirHelp);
	Chk_AllowWeaponShake = CreateCheckbox(AllowWeaponShakeText, AllowWeaponShakeHelp);
	Chk_AutoReady = CreateCheckbox(AutoReadyText, AutoReadyHelp);
	Chk_ShowDeathReport = CreateCheckbox(ShowDeathReportText, ShowDeathReportHelp);
	Chk_SmoothFOVChanges = CreateCheckbox(SmoothFOVChangesText, SmoothFOVChangesHelp);
	Chk_NoSmoothing = CreateCheckbox(NoSmoothingText, NoSmoothingHelp);
	Chk_UseOldMouseInput = CreateCheckbox(UseOldMouseInputText, UseOldMouseInputHelp);
	Edit_MinDodgeClickTime = CreateEdit(ECT_Real, MinDodgeClickTimeText, MinDodgeClickTimeHelp, , 64);
	Edit_DesiredNetUpdateRate = CreateEdit(ECT_Integer, DesiredNetUpdateRateText, DesiredNetUpdateRateHelp, 4, 32);
	Edit_DesiredNetspeed = CreateEdit(ECT_Integer, DesiredNetspeedText, DesiredNetspeedHelp, , 64);
	Edit_FakeCAPInterval = CreateEdit(ECT_Real, FakeCAPIntervalText, FakeCAPIntervalHelp, , 64);

	Lbl_AutoDemo = CreateSeparator(AutoDemoLblText);
	Chk_AutoDemo = CreateCheckbox(AutoDemoText, AutoDemoHelp);
	Edit_DemoMask = CreateEditResizable(ECT_Text, DemoMaskText, 0.7, 100, MaxInt, DemoMaskHelp);
	Edit_DemoPath = CreateEditResizable(ECT_Text, DemoPathText, 0.7, 100, MaxInt, DemoPathHelp);
	Edit_DemoChar = CreateEdit(ECT_Text, DemoCharText, DemoCharHelp, 1, 14);

	Lbl_ForceModels = CreateSeparator(ForceModelsLblText);
	Chk_ForceModels = CreateCheckbox(ForceModelsText, ForceModelsHelp);
	Cmb_DesiredSkin = CreateComboBox(DesiredSkinText, DesiredSkinHelp, false, 150);
	Cmb_DesiredSkinFemale = CreateComboBox(DesiredSkinFemaleText, DesiredSkinFemaleHelp, false, 150);
	Cmb_DesiredTeamSkin = CreateComboBox(DesiredTeamSkinText, DesiredTeamSkinHelp, false, 150);
	Cmb_DesiredTeamSkinFemale = CreateComboBox(DesiredTeamSkinFemaleText, DesiredTeamSkinFemaleHelp, false, 150);
	SetUpForcedModelComboBox(Cmb_DesiredSkin);
	SetUpForcedModelComboBox(Cmb_DesiredSkinFemale);
	SetUpForcedModelComboBox(Cmb_DesiredTeamSkin);
	SetUpForcedModelComboBox(Cmb_DesiredTeamSkinFemale);

	Lbl_SuperShockRifle = CreateSeparator(SuperShockRifleText);
	Cmb_cShockBeam = CreateComboBox(cShockBeamText, cShockBeamHelp, false, 150);
	Cmb_cShockBeam.AddItem(cShockBeamDefault);
	Cmb_cShockBeam.AddItem(cShockBeamTeamColored);
	Cmb_cShockBeam.AddItem(cShockBeamHidden);
	Cmb_cShockBeam.AddItem(cShockBeamInstant);
	Chk_HideOwnBeam = CreateCheckbox(HideOwnBeamText, HideOwnBeamHelp);

	Btn_Save = UWindowSmallButton(CreateControl(class'UWindowSmallButton', WinWidth-PaddingX-72, ControlOffset, 32, 16));
	Btn_Save.SetText(SaveButtonText);
	Btn_Save.ToolTipString = SaveButtonToolTip;
	Btn_Close = UWindowSmallButton(CreateControl(class'UWindowSmallCloseButton', WinWidth-PaddingX-32, ControlOffset, 32, 16));
	ControlOffset += 16;

	ControlOffset += PaddingY;

	Load();
}

function AfterCreate() {
	super.AfterCreate();

	DesiredWidth = 180;
	DesiredHeight = ControlOffset;
}

function BeforePaint(Canvas C, float X, float Y) {
	local float WndWidth;
	local UWindowDialogControl DC;

	super.BeforePaint(C, X, Y);

	WndWidth = WinWidth - 2*PaddingX;

	for (DC = SettingControls; DC != none; DC = NextControl(DC)) {
		switch(DC.Class.Name) {
			case 'IGPlus_Checkbox': DC.SetSize(WndWidth, 1); break;
			default:
				DC.SetSize(WndWidth, DC.WinHeight);
				break;
		}
	}

	Btn_Close.AutoWidth(C);
	Btn_Close.WinLeft = WinWidth-PaddingX-Btn_Close.WinWidth;

	Btn_Save.AutoWidth(C);
	Btn_Save.WinLeft = WinWidth-PaddingX-Btn_Close.WinWidth-5-Btn_Save.WinWidth;
}

function Notify(UWindowDialogControl C, byte E)
{
	Super.Notify(C, E);

	if (E == DE_Click && C == Btn_Save)
		Save();
}

function Load() {
	if (Settings == none)
		Settings = FindSettingsObject();
	if (Settings == none)
		return;

	Chk_ShootDead.bChecked = Settings.bShootDead;
	Chk_DoEndShot.bChecked = Settings.bDoEndShot;
	Chk_UnlitSkins.bChecked = Settings.bUnlitSkins;
	Chk_NoOwnFootsteps.bChecked = Settings.bNoOwnFootsteps;
	Chk_ReduceEyeHeightInAir.bChecked = Settings.bReduceEyeHeightInAir;
	Chk_AllowWeaponShake.bChecked = Settings.bAllowWeaponShake;
	Chk_AutoReady.bChecked = Settings.bAutoReady;
	Chk_ShowDeathReport.bChecked = Settings.bShowDeathReport;
	Chk_SmoothFOVChanges.bChecked = Settings.bSmoothFOVChanges;
	Chk_NoSmoothing.bChecked = Settings.bNoSmoothing;
	Chk_UseOldMouseInput.bChecked = Settings.bUseOldMouseInput;
	Edit_MinDodgeClickTime.SetValue(string(Settings.MinDodgeClickTime));
	Edit_DesiredNetUpdateRate.SetValue(string(int(Settings.DesiredNetUpdateRate)));
	Edit_DesiredNetspeed.SetValue(string(Settings.DesiredNetspeed));
	Edit_FakeCAPInterval.SetValue(string(Settings.FakeCAPInterval));

	Chk_AutoDemo.bChecked = Settings.bAutoDemo;
	Edit_DemoMask.SetValue(Settings.DemoMask);
	Edit_DemoPath.SetValue(Settings.DemoPath);
	Edit_DemoChar.SetValue(Settings.DemoChar);

	Chk_ForceModels.bChecked = Settings.bForceModels;
	Cmb_DesiredSkin.SetSelectedIndex(Clamp(Settings.DesiredSkin + 1, 0, 18));
	Cmb_DesiredSkinFemale.SetSelectedIndex(Clamp(Settings.DesiredSkinFemale + 1, 0, 18));
	Cmb_DesiredTeamSkin.SetSelectedIndex(Clamp(Settings.DesiredTeamSkin + 1, 0, 18));
	Cmb_DesiredTeamSkinFemale.SetSelectedIndex(Clamp(Settings.DesiredTeamSkinFemale + 1, 0, 18));

	Cmb_cShockBeam.SetSelectedIndex(Clamp(Settings.cShockBeam - 1, 0, 3));
	Chk_HideOwnBeam.bChecked = Settings.bHideOwnBeam;

	bLoadSucceeded = true;
}

function Save() {
	if (Settings == none)
		Settings = FindSettingsObject();
	if (Settings == none)
		return;

	if (bLoadSucceeded == false)
		return;

	Settings.bShootDead = Chk_ShootDead.bChecked;
	Settings.bDoEndShot = Chk_DoEndShot.bChecked;
	Settings.bUnlitSkins = Chk_UnlitSkins.bChecked;
	Settings.bNoOwnFootsteps = Chk_NoOwnFootsteps.bChecked;
	Settings.bReduceEyeHeightInAir = Chk_ReduceEyeHeightInAir.bChecked;
	Settings.bAllowWeaponShake = Chk_AllowWeaponShake.bChecked;
	Settings.bAutoReady = Chk_AutoReady.bChecked;
	Settings.bShowDeathReport = Chk_ShowDeathReport.bChecked;
	Settings.bSmoothFOVChanges = Chk_SmoothFOVChanges.bChecked;
	Settings.bNoSmoothing = Chk_NoSmoothing.bChecked;
	Settings.bUseOldMouseInput = Chk_UseOldMouseInput.bChecked;
	Settings.MinDodgeClickTime = float(Edit_MinDodgeClickTime.GetValue());
	Settings.DesiredNetUpdateRate = int(Edit_DesiredNetUpdateRate.GetValue());
	Settings.DesiredNetspeed = int(Edit_DesiredNetspeed.GetValue());
	Settings.FakeCAPInterval = int(Edit_FakeCAPInterval.GetValue());

	Settings.bAutoDemo = Chk_AutoDemo.bChecked;
	Settings.DemoMask = Edit_DemoMask.GetValue();
	Settings.DemoPath = Edit_DemoPath.GetValue();
	Settings.DemoChar = Edit_DemoChar.GetValue();

	Settings.bForceModels = Chk_ForceModels.bChecked;
	Settings.DesiredSkin = Cmb_DesiredSkin.GetSelectedIndex() - 1;
	Settings.DesiredSkinFemale = Cmb_DesiredSkinFemale.GetSelectedIndex() - 1;
	Settings.DesiredTeamSkin = Cmb_DesiredTeamSkin.GetSelectedIndex() - 1;
	Settings.DesiredTeamSkinFemale = Cmb_DesiredTeamSkinFemale.GetSelectedIndex() - 1;

	Settings.cShockBeam = Cmb_cShockBeam.GetSelectedIndex() + 1;
	Settings.bHideOwnBeam = Chk_HideOwnBeam.bChecked;

	Settings.SaveConfig();
}

function SaveConfigs() {
	local UWindowWindow Dialog;

	super.SaveConfigs();

	Dialog = GetParent(class'UWindowFramedWindow');

	Settings.MenuX = Dialog.WinLeft;
	Settings.MenuY = Dialog.WinTop;
	Settings.MenuWidth = Dialog.WinWidth;
	Settings.MenuHeight = Dialog.WinHeight;

	Settings.SaveConfig();
}

defaultproperties
{
	MoreInformationText="Right-click on settings to get more information"

	GeneralText="General"

	ShootDeadText="Enable Shooting Corpses"
	ShootDeadHelp="If checked, corpses can be hit by your lag-compensated shots"

	DoEndShotText="Take Screenshot After Match"
	DoEndShotHelp="If checked, automatically takes a screenshot after the end of a match"

	UnlitSkinsText="Show Player Skins Unlit"
	UnlitSkinsHelp="If checked and allowed by server, skins of players will not be affected by lighting"

	NoOwnFootstepsText="Disable Own Footsteps"
	NoOwnFootstepsHelp="If checked, dont play sounds for your own footsteps"

	ReduceEyeHeightInAirText="Reduce EyeHeight In Air"
	ReduceEyeHeightInAirHelp="If checked, EyeHeight is reduced while player is in the air"

	AllowWeaponShakeText="Allow Weapon Shake"
	AllowWeaponShakeHelp="If checked, weapons can shake the camera when fired"

	AutoReadyText="Auto Ready"
	AutoReadyHelp="If checked, automatically ready up with the first spawn during warmup"

	ShowDeathReportText="Show Death Report"
	ShowDeathReportHelp="If checked, prints a report of damage taken and its source since when you last healed"

	SmoothFOVChangesText="Smooth FOV Changes"
	SmoothFOVChangesHelp="If checked, changes to your FOV are smoothed"

	NoSmoothingText="Disable Mouse Smoothing"
	NoSmoothingHelp="If checked, mouse movement is not smoothed at all"

	UseOldMouseInputText="Use Old Mouse Input"
	UseOldMouseInputHelp="If checked, mouse input is rounded like in v436, otherwise use v469-style mouse input"

	MinDodgeClickTimeText="Min Dodge Click Time"
	MinDodgeClickTimeHelp="Minimum time in seconds between two taps to count as dodge"

	DesiredNetUpdateRateText="Desired Net Update Rate"
	DesiredNetUpdateRateHelp="How often your client wants to send a position update to the server per second"

	DesiredNetspeedText="Desired Netspeed"
	DesiredNetspeedHelp="IG+ will try keeping your netspeed at this value, if the server allows"

	FakeCAPIntervalText="Fake CAP Interval"
	FakeCAPIntervalHelp="Server will acknowledge your movement every this many seconds"

	AutoDemoLblText="Auto Demo"

	AutoDemoText="Enable AutoDemo"
	AutoDemoHelp="If checked, automatically starts recording a demo when the match starts"

	DemoMaskText="Demo Name Mask"
	DemoMaskHelp="Mask for the name of automatically recorded demos; MUST NOT contain spaces\\n%E --> Name of the map file\\n%F --> Title of the map\\n%D --> Day (two digits)\\n%M --> Month (two digits)\\n%Y --> Year\\n%H --> Hour\\n%N --> Minute\\n%T --> Combined Hour and Minute (two digits each)\\n%C --> Clan Tags (detected by determining common prefix of all players on a team, or 'Unknown')\\n%L --> Name of the recording player\\n%% --> Replaced with a single %"

	DemoPathText="Demo Path"
	DemoPathHelp="Path to store automatically recorded demos in; MUST NOT contain spaces"

	DemoCharText="Demo Char"
	DemoCharHelp="Replacement character for those that cannot be used in file-names"

	ForceModelsLblText="Forced Skins"

	ForceModelsText="Enable Forcing Skins"
	ForceModelsHelp="If checked, enables forcing of skins of other players"

	DesiredSkinText="Skin - Male Enemies"
	DesiredSkinHelp="Which skin to use for enemies that use a male skin"

	DesiredSkinFemaleText="Skin - Female Enemies"
	DesiredSkinFemaleHelp="Which skin to use for enemies that use a female skin"

	DesiredTeamSkinText="Skin - Male Friendlies"
	DesiredTeamSkinHelp="Which skin to use for team-mates that use a male skin"

	DesiredTeamSkinFemaleText="Skin - Female Friendlies"
	DesiredTeamSkinFemaleHelp="Which skin to use for team-mates that use a female skin"

	ForcedModelDefault="Do Not Force"
	ForcedModelAphex="Aphex"
	ForcedModelFemaleCommando="Female Commando"
	ForcedModelFemaleMercenary="Female Mercenary"
	ForcedModelFemaleNecris="Female Necris"
	ForcedModelFemaleMarine="Female Marine"
	ForcedModelFemaleMetalGuard="Female Metal Guard"
	ForcedModelFemaleSoldier="Female Soldier"
	ForcedModelVenom="Venom"
	ForcedModelFemaleWarMachine="Female War Machine"
	ForcedModelMaleCommando="Male Commando"
	ForcedModelMaleMercenary="Male Mercenary"
	ForcedModelMaleNecris="Male Necris"
	ForcedModelMaleMarine="Male Marine"
	ForcedModelMaleMetalGuard="Male Metal Guard"
	ForcedModelRawSteel="RawSteel"
	ForcedModelMaleSoldier="Male Soldier"
	ForcedModelMaleWarMachine="Male War Machine"
	ForcedModelXan="Xan"

	SuperShockRifleText="IG+ Super Shock Rifle";

	cShockBeamText="SSR Beam Style"
	cShockBeamHelp="How to render the beams fired by the IG+ SSR"

	cShockBeamDefault="Default"
	cShockBeamTeamColored="Team Colored"
	cShockBeamHidden="Hidden"
	cShockBeamInstant="Instant"

	HideOwnBeamText="Always Hide Own Beams"
	HideOwnBeamHelp="If checked, your own beams will always be hidden"

	SaveButtonText="Save"
	SaveButtonToolTip="Saves the current settings to InstaGibPlus.ini"

	PaddingX=20
	PaddingY=20
	LineSpacing=20
	SeparatorSpacing=32
}