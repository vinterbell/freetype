const std = @import("std");

pub const Int16 = c_short;
pub const UInt16 = c_ushort;
pub const Int32 = c_int;
pub const UInt32 = c_uint;
pub const Fast = c_int;
pub const UFast = c_uint;
pub const Int64 = c_longlong;
pub const UInt64 = c_ulonglong;
pub const Memory = [*c]MemoryRec;
pub const Alloc_Func = ?*const fn (Memory, c_long) callconv(.c) ?*anyopaque;
pub const Free_Func = ?*const fn (Memory, ?*anyopaque) callconv(.c) void;
pub const Realloc_Func = ?*const fn (Memory, c_long, c_long, ?*anyopaque) callconv(.c) ?*anyopaque;
pub const MemoryRec = extern struct {
    user: ?*anyopaque = null,
    alloc: Alloc_Func = null,
    free: Free_Func = null,
    realloc: Realloc_Func = null,
};
pub const StreamDesc = extern union {
    value: c_long,
    pointer: ?*anyopaque,
};
pub const Stream = ?*StreamRec;
pub const Stream_IoFunc = ?*const fn (Stream, c_ulong, [*c]u8, c_ulong) callconv(.c) c_ulong;
pub const Stream_CloseFunc = ?*const fn (Stream) callconv(.c) void;
pub const StreamRec = extern struct {
    base: [*c]u8 = null,
    size: c_ulong = 0,
    pos: c_ulong = 0,
    descriptor: StreamDesc,
    pathname: StreamDesc,
    read: Stream_IoFunc = null,
    close: Stream_CloseFunc = null,
    memory: Memory = null,
    cursor: [*c]u8 = null,
    limit: [*c]u8 = null,
};
pub const Pos = c_long;
pub const Vector = extern struct {
    x: Pos = 0,
    y: Pos = 0,
};
pub const BBox = extern struct {
    xMin: Pos = 0,
    yMin: Pos = 0,
    xMax: Pos = 0,
    yMax: Pos = 0,
};
pub const Pixel_Mode = enum(c_uint) {
    NONE = 0,
    MONO = 1,
    GRAY = 2,
    GRAY2 = 3,
    GRAY4 = 4,
    LCD = 5,
    LCD_V = 6,
    BGRA = 7,
    MAX = 8,
};
pub const Bitmap = extern struct {
    rows: c_uint = 0,
    width: c_uint = 0,
    pitch: c_int = 0,
    buffer: [*c]u8 = null,
    num_grays: c_ushort = 0,
    pixel_mode: u8 = 0,
    palette_mode: u8 = 0,
    palette: ?*anyopaque = null,
};
pub const Outline = extern struct {
    n_contours: c_ushort = 0,
    n_points: c_ushort = 0,
    points: [*c]Vector = null,
    tags: [*c]u8 = null,
    contours: [*c]c_ushort = null,
    flags: c_int = 0,
};
pub const Outline_MoveToFunc = ?*const fn (*const Vector, ?*anyopaque) callconv(.c) c_int;
pub const Outline_LineToFunc = ?*const fn (*const Vector, ?*anyopaque) callconv(.c) c_int;
pub const Outline_ConicToFunc = ?*const fn (*const Vector, *const Vector, ?*anyopaque) callconv(.c) c_int;
pub const Outline_CubicToFunc = ?*const fn (*const Vector, *const Vector, *const Vector, ?*anyopaque) callconv(.c) c_int;
pub const Outline_Funcs = extern struct {
    move_to: Outline_MoveToFunc = null,
    line_to: Outline_LineToFunc = null,
    conic_to: Outline_ConicToFunc = null,
    cubic_to: Outline_CubicToFunc = null,
    shift: c_int = 0,
    delta: Pos = 0,
};
pub const Glyph_Format = enum(c_uint) {
    NONE = 0,
    COMPOSITE = 1668246896,
    BITMAP = 1651078259,
    OUTLINE = 1869968492,
    PLOTTER = 1886154612,
    SVG = 1398163232,
};
pub const Span = extern struct {
    x: c_short = 0,
    len: c_ushort = 0,
    coverage: u8 = 0,
};
pub const SpanFunc = ?*const fn (c_int, c_int, [*c]const Span, ?*anyopaque) callconv(.c) void;
pub const Raster_BitTest_Func = ?*const fn (c_int, c_int, ?*anyopaque) callconv(.c) c_int;
pub const Raster_BitSet_Func = ?*const fn (c_int, c_int, ?*anyopaque) callconv(.c) void;
pub const Raster_Params = extern struct {
    target: [*c]const Bitmap = null,
    source: ?*const anyopaque = null,
    flags: c_int = 0,
    gray_spans: SpanFunc = null,
    black_spans: SpanFunc = null,
    bit_test: Raster_BitTest_Func = null,
    bit_set: Raster_BitSet_Func = null,
    user: ?*anyopaque = null,
    clip_box: BBox = .{},
};
pub const Raster = ?*opaque {};
pub const Raster_NewFunc = ?*const fn (?*anyopaque, [*c]Raster) callconv(.c) c_int;
pub const Raster_DoneFunc = ?*const fn (Raster) callconv(.c) void;
pub const Raster_ResetFunc = ?*const fn (Raster, [*c]u8, c_ulong) callconv(.c) void;
pub const Raster_SetModeFunc = ?*const fn (Raster, c_ulong, ?*anyopaque) callconv(.c) c_int;
pub const Raster_RenderFunc = ?*const fn (Raster, [*c]const Raster_Params) callconv(.c) c_int;
pub const Raster_Funcs = extern struct {
    glyph_format: Glyph_Format = .NONE,
    raster_new: Raster_NewFunc = null,
    raster_reset: Raster_ResetFunc = null,
    raster_set_mode: Raster_SetModeFunc = null,
    raster_render: Raster_RenderFunc = null,
    raster_done: Raster_DoneFunc = null,
};
pub const Bool = u8;
pub const FWord = c_short;
pub const UFWord = c_ushort;
pub const Char = i8;
pub const Byte = u8;
pub const Bytes = [*c]const Byte;
pub const Tag = UInt32;
pub const String = u8;
pub const Short = c_short;
pub const UShort = c_ushort;
pub const Int = c_int;
pub const UInt = c_uint;
pub const Long = c_long;
pub const ULong = c_ulong;
pub const F2Dot14 = c_short;
pub const F26Dot6 = c_long;
pub const Fixed = c_long;
pub const Pointer = ?*anyopaque;
pub const Offset = usize;
pub const PtrDist = usize;
pub const UnitVector = extern struct {
    x: F2Dot14 = 0,
    y: F2Dot14 = 0,
};
pub const Matrix = extern struct {
    xx: Fixed = 0,
    xy: Fixed = 0,
    yx: Fixed = 0,
    yy: Fixed = 0,
};
pub const Data = extern struct {
    pointer: [*c]const Byte = null,
    length: UInt = 0,
};
pub const Generic_Finalizer = ?*const fn (?*anyopaque) callconv(.c) void;
pub const Generic = extern struct {
    data: ?*anyopaque = null,
    finalizer: Generic_Finalizer = null,
};
pub const ListNode = [*c]ListNodeRec;
pub const ListNodeRec = extern struct {
    prev: ListNode = null,
    next: ListNode = null,
    data: ?*anyopaque = null,
};
pub const ListRec = extern struct {
    head: ListNode = null,
    tail: ListNode = null,
};
// pub const Mod_Err_Base: c_int = 0;
// pub const Mod_Err_Autofit: c_int = 0;
// pub const Mod_Err_BDF: c_int = 0;
// pub const Mod_Err_Bzip2: c_int = 0;
// pub const Mod_Err_Cache: c_int = 0;
// pub const Mod_Err_CFF: c_int = 0;
// pub const Mod_Err_CID: c_int = 0;
// pub const Mod_Err_Gzip: c_int = 0;
// pub const Mod_Err_LZW: c_int = 0;
// pub const Mod_Err_OTvalid: c_int = 0;
// pub const Mod_Err_PCF: c_int = 0;
// pub const Mod_Err_PFR: c_int = 0;
// pub const Mod_Err_PSaux: c_int = 0;
// pub const Mod_Err_PShinter: c_int = 0;
// pub const Mod_Err_PSnames: c_int = 0;
// pub const Mod_Err_Raster: c_int = 0;
// pub const Mod_Err_SFNT: c_int = 0;
// pub const Mod_Err_Smooth: c_int = 0;
// pub const Mod_Err_TrueType: c_int = 0;
// pub const Mod_Err_Type1: c_int = 0;
// pub const Mod_Err_Type42: c_int = 0;
// pub const Mod_Err_Winfonts: c_int = 0;
// pub const Mod_Err_GXvalid: c_int = 0;
// pub const Mod_Err_Sdf: c_int = 0;
// pub const Mod_Err_Max: c_int = 1;
// const enum_unnamed_1 = c_uint;
pub const Error = enum(c_uint) {
    Ok = 0,
    Cannot_Open_Resource = 1,
    Unknown_File_Format = 2,
    Invalid_File_Format = 3,
    Invalid_Version = 4,
    Lower_Module_Version = 5,
    Invalid_Argument = 6,
    Unimplemented_Feature = 7,
    Invalid_Table = 8,
    Invalid_Offset = 9,
    Array_Too_Large = 10,
    Missing_Module = 11,
    Missing_Property = 12,
    Invalid_Glyph_Index = 16,
    Invalid_Character_Code = 17,
    Invalid_Glyph_Format = 18,
    Cannot_Render_Glyph = 19,
    Invalid_Outline = 20,
    Invalid_Composite = 21,
    Too_Many_Hints = 22,
    Invalid_Pixel_Size = 23,
    Invalid_SVG_Document = 24,
    Invalid_Handle = 32,
    Invalid_Library_Handle = 33,
    Invalid_Driver_Handle = 34,
    Invalid_Face_Handle = 35,
    Invalid_Size_Handle = 36,
    Invalid_Slot_Handle = 37,
    Invalid_CharMap_Handle = 38,
    Invalid_Cache_Handle = 39,
    Invalid_Stream_Handle = 40,
    Too_Many_Drivers = 48,
    Too_Many_Extensions = 49,
    Out_Of_Memory = 64,
    Unlisted_Object = 65,
    Cannot_Open_Stream = 81,
    Invalid_Stream_Seek = 82,
    Invalid_Stream_Skip = 83,
    Invalid_Stream_Read = 84,
    Invalid_Stream_Operation = 85,
    Invalid_Frame_Operation = 86,
    Nested_Frame_Access = 87,
    Invalid_Frame_Read = 88,
    Raster_Uninitialized = 96,
    Raster_Corrupted = 97,
    Raster_Overflow = 98,
    Raster_Negative_Height = 99,
    Too_Many_Caches = 112,
    Invalid_Opcode = 128,
    Too_Few_Arguments = 129,
    Stack_Overflow = 130,
    Code_Overflow = 131,
    Bad_Argument = 132,
    Divide_By_Zero = 133,
    Invalid_Reference = 134,
    Debug_OpCode = 135,
    ENDF_In_Exec_Stream = 136,
    Nested_DEFS = 137,
    Invalid_CodeRange = 138,
    Execution_Too_Long = 139,
    Too_Many_Function_Defs = 140,
    Too_Many_Instruction_Defs = 141,
    Table_Missing = 142,
    Horiz_Header_Missing = 143,
    Locations_Missing = 144,
    Name_Table_Missing = 145,
    CMap_Table_Missing = 146,
    Hmtx_Table_Missing = 147,
    Post_Table_Missing = 148,
    Invalid_Horiz_Metrics = 149,
    Invalid_CharMap_Format = 150,
    Invalid_PPem = 151,
    Invalid_Vert_Metrics = 152,
    Could_Not_Find_Context = 153,
    Invalid_Post_Table_Format = 154,
    Invalid_Post_Table = 155,
    DEF_In_Glyf_Bytecode = 156,
    Missing_Bitmap = 157,
    Missing_SVG_Hooks = 158,
    Syntax_Error = 160,
    Stack_Underflow = 161,
    Ignore = 162,
    No_Unicode_Glyph_Name = 163,
    Glyph_Too_Big = 164,
    Missing_Startfont_Field = 176,
    Missing_Font_Field = 177,
    Missing_Size_Field = 178,
    Missing_Fontboundingbox_Field = 179,
    Missing_Chars_Field = 180,
    Missing_Startchar_Field = 181,
    Missing_Encoding_Field = 182,
    Missing_Bbx_Field = 183,
    Bbx_Too_Big = 184,
    Corrupted_Font_Header = 185,
    Corrupted_Font_Glyphs = 186,
    Max = 187,
};
pub const Error_String = FT_Error_String;
extern fn FT_Error_String(error_code: Error) [*c]const u8;
pub const Glyph_Metrics = extern struct {
    width: Pos = 0,
    height: Pos = 0,
    horiBearingX: Pos = 0,
    horiBearingY: Pos = 0,
    horiAdvance: Pos = 0,
    vertBearingX: Pos = 0,
    vertBearingY: Pos = 0,
    vertAdvance: Pos = 0,
};
pub const Bitmap_Size = extern struct {
    height: Short = 0,
    width: Short = 0,
    size: Pos = 0,
    x_ppem: Pos = 0,
    y_ppem: Pos = 0,
};
pub const LibraryRec = opaque {};
pub const Library = ?*LibraryRec;
pub const ModuleRec = opaque {};
pub const Module = ?*ModuleRec;
pub const DriverRec = opaque {};
pub const Driver = ?*DriverRec;
pub const RendererRec = opaque {};
pub const Renderer = ?*RendererRec;
pub const Face = [*c]FaceRec;
pub const Encoding = enum(c_uint) {
    NONE = 0,
    MS_SYMBOL = 1937337698,
    UNICODE = 1970170211,
    SJIS = 1936353651,
    PRC = 1734484000,
    BIG5 = 1651074869,
    WANSUNG = 2002873971,
    JOHAB = 1785686113,
    // MS_BIG5 = 1651074869,
    // MS_WANSUNG = 2002873971,
    // MS_JOHAB = 1785686113,
    ADOBE_STANDARD = 1094995778,
    ADOBE_EXPERT = 1094992453,
    ADOBE_CUSTOM = 1094992451,
    ADOBE_LATIN_1 = 1818326065,
    OLD_LATIN_2 = 1818326066,
    APPLE_ROMAN = 1634889070,

    pub const GB2312: Encoding = .PRC;
    pub const MS_SJIS: Encoding = .SJIS;
    pub const MS_GB2312: Encoding = .GB2312;
    pub const MS_BIG5: Encoding = .BIG5;
    pub const MS_WANSUNG: Encoding = .WANSUNG;
    pub const MS_JOHAB: Encoding = .JOHAB;
};
pub const CharMapRec = extern struct {
    face: Face = null,
    encoding: Encoding = .NONE,
    platform_id: UShort = 0,
    encoding_id: UShort = 0,
};
pub const CharMap = [*c]CharMapRec;
pub const SubGlyphRec = opaque {};
pub const SubGlyph = ?*SubGlyphRec;
pub const Slot_InternalRec = opaque {};
pub const Slot_Internal = ?*Slot_InternalRec;
pub const GlyphSlotRec = extern struct {
    library: Library = null,
    face: Face = null,
    next: GlyphSlot = null,
    glyph_index: UInt = 0,
    generic: Generic = .{},
    metrics: Glyph_Metrics = .{},
    linearHoriAdvance: Fixed = 0,
    linearVertAdvance: Fixed = 0,
    advance: Vector = .{},
    format: Glyph_Format = .NONE,
    bitmap: Bitmap = .{},
    bitmap_left: Int = 0,
    bitmap_top: Int = 0,
    outline: Outline = .{},
    num_subglyphs: UInt = 0,
    subglyphs: SubGlyph = null,
    control_data: ?*anyopaque = null,
    control_len: c_long = 0,
    lsb_delta: Pos = 0,
    rsb_delta: Pos = 0,
    other: ?*anyopaque = null,
    internal: Slot_Internal = null,
};
pub const GlyphSlot = [*c]GlyphSlotRec;
pub const Size_Metrics = extern struct {
    x_ppem: UShort = 0,
    y_ppem: UShort = 0,
    x_scale: Fixed = 0,
    y_scale: Fixed = 0,
    ascender: Pos = 0,
    descender: Pos = 0,
    height: Pos = 0,
    max_advance: Pos = 0,
};
pub const Size_InternalRec = opaque {};
pub const Size_Internal = ?*Size_InternalRec;
pub const SizeRec = extern struct {
    face: Face = null,
    generic: Generic = .{},
    metrics: Size_Metrics = .{},
    internal: Size_Internal = null,
};
pub const Size = [*c]SizeRec;
pub const Face_InternalRec = opaque {};
pub const Face_Internal = ?*Face_InternalRec;
pub const FaceRec = extern struct {
    num_faces: Long = 0,
    face_index: Long = 0,
    face_flags: Long = 0,
    style_flags: Long = 0,
    num_glyphs: Long = 0,
    family_name: [*c]String = null,
    style_name: [*c]String = null,
    num_fixed_sizes: Int = 0,
    available_sizes: [*c]Bitmap_Size = null,
    num_charmaps: Int = 0,
    charmaps: [*c]CharMap = null,
    generic: Generic = .{},
    bbox: BBox = .{},
    units_per_EM: UShort = 0,
    ascender: Short = 0,
    descender: Short = 0,
    height: Short = 0,
    max_advance_width: Short = 0,
    max_advance_height: Short = 0,
    underline_position: Short = 0,
    underline_thickness: Short = 0,
    glyph: GlyphSlot = null,
    size: Size = null,
    charmap: CharMap = null,
    driver: Driver = null,
    memory: Memory = null,
    stream: Stream = null,
    sizes_list: ListRec = .{},
    autohint: Generic = .{},
    extensions: ?*anyopaque = null,
    internal: Face_Internal = null,
};
pub const Init_FreeType = FT_Init_FreeType;
extern fn FT_Init_FreeType(alibrary: [*c]Library) Error;
pub const Done_FreeType = FT_Done_FreeType;
extern fn FT_Done_FreeType(library: Library) Error;
pub const Parameter = extern struct {
    tag: ULong = 0,
    data: Pointer = null,
};
pub const Open_Args = extern struct {
    flags: UInt = 0,
    memory_base: [*c]const Byte = null,
    memory_size: Long = 0,
    pathname: [*c]String = null,
    stream: Stream = null,
    driver: Module = null,
    num_params: Int = 0,
    params: [*c]Parameter = null,
};
pub const New_Face = FT_New_Face;
extern fn FT_New_Face(library: Library, filepathname: [*c]const u8, face_index: Long, aface: [*c]Face) Error;
pub const New_Memory_Face = FT_New_Memory_Face;
extern fn FT_New_Memory_Face(library: Library, file_base: [*c]const Byte, file_size: Long, face_index: Long, aface: [*c]Face) Error;
pub const Open_Face = FT_Open_Face;
extern fn FT_Open_Face(library: Library, args: [*c]const Open_Args, face_index: Long, aface: [*c]Face) Error;
pub const Attach_File = FT_Attach_File;
extern fn FT_Attach_File(face: Face, filepathname: [*c]const u8) Error;
pub const Attach_Stream = FT_Attach_Stream;
extern fn FT_Attach_Stream(face: Face, parameters: [*c]const Open_Args) Error;
pub const Reference_Face = FT_Reference_Face;
extern fn FT_Reference_Face(face: Face) Error;
pub const Done_Face = FT_Done_Face;
extern fn FT_Done_Face(face: Face) Error;
pub const Select_Size = FT_Select_Size;
extern fn FT_Select_Size(face: Face, strike_index: Int) Error;
pub const Size_Request_Type = enum(c_uint) {
    NOMINAL = 0,
    REAL_DIM = 1,
    BBOX = 2,
    CELL = 3,
    SCALES = 4,
    MAX = 5,
};
pub const Size_RequestRec = extern struct {
    type: Size_Request_Type = .NOMINAL,
    width: Long = 0,
    height: Long = 0,
    horiResolution: UInt = 0,
    vertResolution: UInt = 0,
};
pub const Size_Request = [*c]Size_RequestRec;
pub const Request_Size = FT_Request_Size;
extern fn FT_Request_Size(face: Face, req: Size_Request) Error;
pub const Set_Char_Size = FT_Set_Char_Size;
extern fn FT_Set_Char_Size(face: Face, char_width: F26Dot6, char_height: F26Dot6, horz_resolution: UInt, vert_resolution: UInt) Error;
pub const Set_Pixel_Sizes = FT_Set_Pixel_Sizes;
extern fn FT_Set_Pixel_Sizes(face: Face, pixel_width: UInt, pixel_height: UInt) Error;
pub const Load_Glyph = FT_Load_Glyph;
extern fn FT_Load_Glyph(face: Face, glyph_index: UInt, load_flags: Int32) Error;
pub const Load_Char = FT_Load_Char;
extern fn FT_Load_Char(face: Face, char_code: ULong, load_flags: Int32) Error;
pub const Set_Transform = FT_Set_Transform;
extern fn FT_Set_Transform(face: Face, matrix: [*c]Matrix, delta: [*c]Vector) void;
pub const Get_Transform = FT_Get_Transform;
extern fn FT_Get_Transform(face: Face, matrix: [*c]Matrix, delta: [*c]Vector) void;
pub const Render_Mode = enum(c_uint) {
    NORMAL = 0,
    LIGHT = 1,
    MONO = 2,
    LCD = 3,
    LCD_V = 4,
    SDF = 5,
    MAX = 6,
};
pub const Render_Glyph = FT_Render_Glyph;
extern fn FT_Render_Glyph(slot: GlyphSlot, render_mode: Render_Mode) Error;
pub const Kerning_Mode = enum(c_uint) {
    DEFAULT = 0,
    UNFITTED = 1,
    UNSCALED = 2,
};
pub const Get_Kerning = FT_Get_Kerning;
extern fn FT_Get_Kerning(face: Face, leglyph: UInt, right_glyph: UInt, kern_mode: UInt, akerning: [*c]Vector) Error;
pub const Get_Track_Kerning = FT_Get_Track_Kerning;
extern fn FT_Get_Track_Kerning(face: Face, point_size: Fixed, degree: Int, akerning: [*c]Fixed) Error;
pub const Select_Charmap = FT_Select_Charmap;
extern fn FT_Select_Charmap(face: Face, encoding: Encoding) Error;
pub const Set_Charmap = FT_Set_Charmap;
extern fn FT_Set_Charmap(face: Face, charmap: CharMap) Error;
pub const Get_Charmap_Index = FT_Get_Charmap_Index;
extern fn FT_Get_Charmap_Index(charmap: CharMap) Int;
pub const Get_Char_Index = FT_Get_Char_Index;
extern fn FT_Get_Char_Index(face: Face, charcode: ULong) UInt;
pub const Get_First_Char = FT_Get_First_Char;
extern fn FT_Get_First_Char(face: Face, agindex: [*c]UInt) ULong;
pub const Get_Next_Char = FT_Get_Next_Char;
extern fn FT_Get_Next_Char(face: Face, char_code: ULong, agindex: [*c]UInt) ULong;
pub const Face_Properties = FT_Face_Properties;
extern fn FT_Face_Properties(face: Face, num_properties: UInt, properties: [*c]Parameter) Error;
pub const Get_Name_Index = FT_Get_Name_Index;
extern fn FT_Get_Name_Index(face: Face, glyph_name: [*c]const String) UInt;
pub const Get_Glyph_Name = FT_Get_Glyph_Name;
extern fn FT_Get_Glyph_Name(face: Face, glyph_index: UInt, buffer: Pointer, buffer_max: UInt) Error;
pub const Get_Postscript_Name = FT_Get_Postscript_Name;
extern fn FT_Get_Postscript_Name(face: Face) [*c]const u8;
pub const Get_SubGlyph_Info = FT_Get_SubGlyph_Info;
extern fn FT_Get_SubGlyph_Info(glyph: GlyphSlot, sub_index: UInt, p_index: [*c]Int, p_flags: [*c]UInt, p_arg1: [*c]Int, p_arg2: [*c]Int, p_transform: [*c]Matrix) Error;
pub const Get_FSType_Flags = FT_Get_FSType_Flags;
extern fn FT_Get_FSType_Flags(face: Face) UShort;
pub const Face_GetCharVariantIndex = FT_Face_GetCharVariantIndex;
extern fn FT_Face_GetCharVariantIndex(face: Face, charcode: ULong, variantSelector: ULong) UInt;
pub const Face_GetCharVariantIsDefault = FT_Face_GetCharVariantIsDefault;
extern fn FT_Face_GetCharVariantIsDefault(face: Face, charcode: ULong, variantSelector: ULong) Int;
pub const Face_GetVariantSelectors = FT_Face_GetVariantSelectors;
extern fn FT_Face_GetVariantSelectors(face: Face) [*c]UInt32;
pub const Face_GetVariantsOfChar = FT_Face_GetVariantsOfChar;
extern fn FT_Face_GetVariantsOfChar(face: Face, charcode: ULong) [*c]UInt32;
pub const Face_GetCharsOfVariant = FT_Face_GetCharsOfVariant;
extern fn FT_Face_GetCharsOfVariant(face: Face, variantSelector: ULong) [*c]UInt32;
pub const MulDiv = FT_MulDiv;
extern fn FT_MulDiv(a: Long, b: Long, c: Long) Long;
pub const MulFix = FT_MulFix;
extern fn FT_MulFix(a: Long, b: Long) Long;
pub const DivFix = FT_DivFix;
extern fn FT_DivFix(a: Long, b: Long) Long;
pub const RoundFix = FT_RoundFix;
extern fn FT_RoundFix(a: Fixed) Fixed;
pub const CeilFix = FT_CeilFix;
extern fn FT_CeilFix(a: Fixed) Fixed;
pub const FloorFix = FT_FloorFix;
extern fn FT_FloorFix(a: Fixed) Fixed;
pub extern fn Vector_Transform(vector: [*c]Vector, matrix: [*c]const Matrix) void;
pub const Library_Version = FT_Library_Version;
extern fn FT_Library_Version(library: Library, amajor: [*c]Int, aminor: [*c]Int, apatch: [*c]Int) void;
pub const Face_CheckTrueTypePatents = FT_Face_CheckTrueTypePatents;
extern fn FT_Face_CheckTrueTypePatents(face: Face) Bool;
pub const Face_SetUnpatentedHinting = FT_Face_SetUnpatentedHinting;
extern fn FT_Face_SetUnpatentedHinting(face: Face, value: Bool) Bool;
pub const Get_Advance = FT_Get_Advance;
extern fn FT_Get_Advance(face: Face, gindex: UInt, load_flags: Int32, padvance: [*c]Fixed) Error;
pub const Get_Advances = FT_Get_Advances;
extern fn FT_Get_Advances(face: Face, start: UInt, count: UInt, load_flags: Int32, padvances: [*c]Fixed) Error;
pub const Outline_Get_BBox = FT_Outline_Get_BBox;
extern fn FT_Outline_Get_BBox(outline: [*c]Outline, abbox: [*c]BBox) Error;
pub const Color = extern struct {
    blue: Byte = 0,
    green: Byte = 0,
    red: Byte = 0,
    alpha: Byte = 0,
};
pub const Palette_Data = extern struct {
    num_palettes: UShort = 0,
    palette_name_ids: [*c]const UShort = null,
    palette_flags: [*c]const UShort = null,
    num_palette_entries: UShort = 0,
    palette_entry_name_ids: [*c]const UShort = null,
};
pub const Palette_Data_Get = FT_Palette_Data_Get;
extern fn FT_Palette_Data_Get(face: Face, apalette: [*c]Palette_Data) Error;
pub const Palette_Select = FT_Palette_Select;
extern fn FT_Palette_Select(face: Face, palette_index: UShort, apalette: [*c][*c]Color) Error;
pub const Palette_Set_Foreground_Color = FT_Palette_Set_Foreground_Color;
extern fn FT_Palette_Set_Foreground_Color(face: Face, foreground_color: Color) Error;
pub const LayerIterator = extern struct {
    num_layers: UInt = 0,
    layer: UInt = 0,
    p: [*c]Byte = null,
};
pub const Get_Color_Glyph_Layer = FT_Get_Color_Glyph_Layer;
extern fn FT_Get_Color_Glyph_Layer(face: Face, base_glyph: UInt, aglyph_index: [*c]UInt, acolor_index: [*c]UInt, iterator: [*c]LayerIterator) Bool;
pub const PaintFormat = enum(c_uint) {
    COLR_LAYERS = 1,
    SOLID = 2,
    LINEAR_GRADIENT = 4,
    RADIAL_GRADIENT = 6,
    SWEEP_GRADIENT = 8,
    GLYPH = 10,
    COLR_GLYPH = 11,
    TRANSFORM = 12,
    TRANSLATE = 14,
    SCALE = 16,
    ROTATE = 24,
    SKEW = 28,
    COMPOSITE = 32,
    MAX = 33,
    UNSUPPORTED = 255,
};
pub const ColorStopIterator = extern struct {
    num_color_stops: UInt = 0,
    current_color_stop: UInt = 0,
    p: [*c]Byte = null,
    read_variable: Bool = 0,
};
pub const ColorIndex = extern struct {
    palette_index: UInt16 = 0,
    alpha: F2Dot14 = 0,
};
pub const ColorStop = extern struct {
    stop_offset: Fixed = 0,
    color: ColorIndex = .{},
};
pub const PaintExtend = enum(c_uint) {
    PAD = 0,
    REPEAT = 1,
    REFLECT = 2,
    MAX = 3,
    UNSUPPORTED = 255,
};
pub const ColorLine = extern struct {
    extend: PaintExtend = .PAD,
    color_stop_iterator: ColorStopIterator = .{},
};
pub const Affine_23 = extern struct {
    xx: Fixed = 0,
    xy: Fixed = 0,
    dx: Fixed = 0,
    yx: Fixed = 0,
    yy: Fixed = 0,
    dy: Fixed = 0,
};
pub const Affine23 = Affine_23;
pub const Composite_Mode = enum(c_uint) {
    CLEAR = 0,
    SRC = 1,
    DEST = 2,
    SRC_OVER = 3,
    DEST_OVER = 4,
    SRC_IN = 5,
    DEST_IN = 6,
    SRC_OUT = 7,
    DEST_OUT = 8,
    SRC_ATOP = 9,
    DEST_ATOP = 10,
    XOR = 11,
    PLUS = 12,
    SCREEN = 13,
    OVERLAY = 14,
    DARKEN = 15,
    LIGHTEN = 16,
    COLOR_DODGE = 17,
    COLOR_BURN = 18,
    HARD_LIGHT = 19,
    SOFT_LIGHT = 20,
    DIFFERENCE = 21,
    EXCLUSION = 22,
    MULTIPLY = 23,
    HSL_HUE = 24,
    HSL_SATURATION = 25,
    HSL_COLOR = 26,
    HSL_LUMINOSITY = 27,
    MAX = 28,
};
pub const Opaque_Paint = extern struct {
    p: [*c]Byte = null,
    insert_root_transform: Bool = 0,
};
pub const OpaquePaint = Opaque_Paint;
pub const PaintColrLayers = extern struct {
    layer_iterator: LayerIterator = .{},
};
pub const PaintSolid = extern struct {
    color: ColorIndex = .{},
};
pub const PaintLinearGradient = extern struct {
    colorline: ColorLine = .{},
    p0: Vector = .{},
    p1: Vector = .{},
    p2: Vector = .{},
};
pub const PaintRadialGradient = extern struct {
    colorline: ColorLine = .{},
    c0: Vector = .{},
    r0: Pos = 0,
    c1: Vector = .{},
    r1: Pos = 0,
};
pub const PaintSweepGradient = extern struct {
    colorline: ColorLine = .{},
    center: Vector = .{},
    start_angle: Fixed = 0,
    end_angle: Fixed = 0,
};
pub const PaintGlyph = extern struct {
    paint: OpaquePaint = .{},
    glyphID: UInt = 0,
};
pub const PaintColrGlyph = extern struct {
    glyphID: UInt = 0,
};
pub const PaintTransform = extern struct {
    paint: OpaquePaint = .{},
    affine: Affine23 = .{},
};
pub const PaintTranslate = extern struct {
    paint: OpaquePaint = .{},
    dx: Fixed = 0,
    dy: Fixed = 0,
};
pub const PaintScale = extern struct {
    paint: OpaquePaint = .{},
    scale_x: Fixed = 0,
    scale_y: Fixed = 0,
    center_x: Fixed = 0,
    center_y: Fixed = 0,
};
pub const PaintRotate = extern struct {
    paint: OpaquePaint = .{},
    angle: Fixed = 0,
    center_x: Fixed = 0,
    center_y: Fixed = 0,
};
pub const PaintSkew = extern struct {
    paint: OpaquePaint = .{},
    x_skew_angle: Fixed = 0,
    y_skew_angle: Fixed = 0,
    center_x: Fixed = 0,
    center_y: Fixed = 0,
};
pub const PaintComposite = extern struct {
    source_paint: OpaquePaint = .{},
    composite_mode: Composite_Mode = .CLEAR,
    backdrop_paint: OpaquePaint = .{},
};
const COLR_Paint_Union = extern union {
    colr_layers: PaintColrLayers,
    glyph: PaintGlyph,
    solid: PaintSolid,
    linear_gradient: PaintLinearGradient,
    radial_gradient: PaintRadialGradient,
    sweep_gradient: PaintSweepGradient,
    transform: PaintTransform,
    translate: PaintTranslate,
    scale: PaintScale,
    rotate: PaintRotate,
    skew: PaintSkew,
    composite: PaintComposite,
    colr_glyph: PaintColrGlyph,
};
pub const COLR_Paint = extern struct {
    format: PaintFormat = .UNSUPPORTED,
    u: COLR_Paint_Union = undefined,
};
pub const Color_Root_Transform = enum(c_uint) {
    INCLUDE_ROOT_TRANSFORM = 0,
    NO_ROOT_TRANSFORM = 1,
    ROOT_TRANSFORM_MAX = 2,
};
pub const ClipBox = extern struct {
    bottom_left: Vector = .{},
    top_left: Vector = .{},
    top_right: Vector = .{},
    bottom_right: Vector = .{},
};
pub const Get_Color_Glyph_Paint = FT_Get_Color_Glyph_Paint;
extern fn FT_Get_Color_Glyph_Paint(face: Face, base_glyph: UInt, root_transform: Color_Root_Transform, paint: [*c]OpaquePaint) Bool;
pub const Get_Color_Glyph_ClipBox = FT_Get_Color_Glyph_ClipBox;
extern fn FT_Get_Color_Glyph_ClipBox(face: Face, base_glyph: UInt, clip_box: [*c]ClipBox) Bool;
pub const Get_Paint_Layers = FT_Get_Paint_Layers;
extern fn FT_Get_Paint_Layers(face: Face, iterator: [*c]LayerIterator, paint: [*c]OpaquePaint) Bool;
pub const Get_Colorline_Stops = FT_Get_Colorline_Stops;
extern fn FT_Get_Colorline_Stops(face: Face, color_stop: [*c]ColorStop, iterator: [*c]ColorStopIterator) Bool;
pub const Get_Paint = FT_Get_Paint;
extern fn FT_Get_Paint(face: Face, opaque_paint: OpaquePaint, paint: [*c]COLR_Paint) Bool;
pub const Bitmap_Init = FT_Bitmap_Init;
extern fn FT_Bitmap_Init(abitmap: [*c]Bitmap) void;
pub const Bitmap_New = FT_Bitmap_New;
extern fn FT_Bitmap_New(abitmap: [*c]Bitmap) void;
pub const Bitmap_Copy = FT_Bitmap_Copy;
extern fn FT_Bitmap_Copy(library: Library, source: [*c]const Bitmap, target: [*c]Bitmap) Error;
pub const Bitmap_Embolden = FT_Bitmap_Embolden;
extern fn FT_Bitmap_Embolden(library: Library, bitmap: [*c]Bitmap, xStrength: Pos, yStrength: Pos) Error;
pub const Bitmap_Convert = FT_Bitmap_Convert;
extern fn FT_Bitmap_Convert(library: Library, source: [*c]const Bitmap, target: [*c]Bitmap, alignment: Int) Error;
pub const Bitmap_Blend = FT_Bitmap_Blend;
extern fn FT_Bitmap_Blend(library: Library, source: [*c]const Bitmap, source_offset: Vector, target: [*c]Bitmap, atarget_offset: [*c]Vector, color: Color) Error;
pub const GlyphSlot_Own_Bitmap = FT_GlyphSlot_Own_Bitmap;
extern fn FT_GlyphSlot_Own_Bitmap(slot: GlyphSlot) Error;
pub const Bitmap_Done = FT_Bitmap_Done;
extern fn FT_Bitmap_Done(library: Library, bitmap: [*c]Bitmap) Error;
pub const LcdFilter = enum(c_uint) {
    NONE = 0,
    DEFAULT = 1,
    LIGHT = 2,
    LEGACY1 = 3,
    LEGACY = 16,
    MAX = 17,
};
pub const Library_SetLcdFilter = FT_Library_SetLcdFilter;
extern fn FT_Library_SetLcdFilter(library: Library, filter: LcdFilter) Error;
pub const Library_SetLcdFilterWeights = FT_Library_SetLcdFilterWeights;
extern fn FT_Library_SetLcdFilterWeights(library: Library, weights: [*c]u8) Error;
pub const LcdFiveTapFilter = [5]Byte;
pub const Library_SetLcdGeometry = FT_Library_SetLcdGeometry;
extern fn FT_Library_SetLcdGeometry(library: Library, sub: [*c]Vector) Error;
pub const New_Size = FT_New_Size;
extern fn FT_New_Size(face: Face, size: [*c]Size) Error;
pub const Done_Size = FT_Done_Size;
extern fn FT_Done_Size(size: Size) Error;
pub const Activate_Size = FT_Activate_Size;
extern fn FT_Activate_Size(size: Size) Error;
pub const Outline_Decompose = FT_Outline_Decompose;
extern fn FT_Outline_Decompose(outline: [*c]Outline, func_interface: [*c]const Outline_Funcs, user: ?*anyopaque) Error;
pub const Outline_New = FT_Outline_New;
extern fn FT_Outline_New(library: Library, numPoints: UInt, numContours: Int, anoutline: [*c]Outline) Error;
pub const Outline_Done = FT_Outline_Done;
extern fn FT_Outline_Done(library: Library, outline: [*c]Outline) Error;
pub const Outline_Check = FT_Outline_Check;
extern fn FT_Outline_Check(outline: [*c]Outline) Error;
pub const Outline_Get_CBox = FT_Outline_Get_CBox;
extern fn FT_Outline_Get_CBox(outline: [*c]const Outline, acbox: [*c]BBox) void;
pub const Outline_Translate = FT_Outline_Translate;
extern fn FT_Outline_Translate(outline: [*c]const Outline, xOffset: Pos, yOffset: Pos) void;
pub const Outline_Copy = FT_Outline_Copy;
extern fn FT_Outline_Copy(source: [*c]const Outline, target: [*c]Outline) Error;
pub const Outline_Transform = FT_Outline_Transform;
extern fn FT_Outline_Transform(outline: [*c]const Outline, matrix: [*c]const Matrix) void;
pub const Outline_Embolden = FT_Outline_Embolden;
extern fn FT_Outline_Embolden(outline: [*c]Outline, strength: Pos) Error;
pub const Outline_EmboldenXY = FT_Outline_EmboldenXY;
extern fn FT_Outline_EmboldenXY(outline: [*c]Outline, xstrength: Pos, ystrength: Pos) Error;
pub const Outline_Reverse = FT_Outline_Reverse;
extern fn FT_Outline_Reverse(outline: [*c]Outline) void;
pub const Outline_Get_Bitmap = FT_Outline_Get_Bitmap;
extern fn FT_Outline_Get_Bitmap(library: Library, outline: [*c]Outline, abitmap: [*c]const Bitmap) Error;
pub const Outline_Render = FT_Outline_Render;
extern fn FT_Outline_Render(library: Library, outline: [*c]Outline, params: [*c]Raster_Params) Error;
pub const Orientation = enum(c_uint) {
    TRUETYPE = 0,
    POSTSCRIPT = 1,
    FILL_RIGHT = 0,
    FILL_LEFT = 1,
    NONE = 2,
};
pub const Outline_Get_Orientation = FT_Outline_Get_Orientation;
extern fn FT_Outline_Get_Orientation(outline: [*c]Outline) Orientation;
pub const Glyph_Class = opaque {};
pub const GlyphRec = extern struct {
    library: Library = null,
    clazz: ?*const Glyph_Class = null,
    format: Glyph_Format = .NONE,
    advance: Vector = .{},
};
pub const Glyph = [*c]GlyphRec;
pub const BitmapGlyphRec = extern struct {
    root: GlyphRec = .{},
    left: Int = 0,
    top: Int = 0,
    bitmap: Bitmap = .{},
};
pub const BitmapGlyph = [*c]BitmapGlyphRec;
pub const OutlineGlyphRec = extern struct {
    root: GlyphRec = .{},
    outline: Outline = .{},
};
pub const OutlineGlyph = [*c]OutlineGlyphRec;
pub const SvgGlyphRec = extern struct {
    root: GlyphRec = .{},
    svg_document: [*c]Byte = null,
    svg_document_length: ULong = 0,
    glyph_index: UInt = 0,
    metrics: Size_Metrics = .{},
    units_per_EM: UShort = 0,
    start_glyph_id: UShort = 0,
    end_glyph_id: UShort = 0,
    transform: Matrix = .{},
    delta: Vector = .{},
};
pub const SvgGlyph = [*c]SvgGlyphRec;
pub const New_Glyph = FT_New_Glyph;
extern fn FT_New_Glyph(library: Library, format: Glyph_Format, aglyph: [*c]Glyph) Error;
pub const Get_Glyph = FT_Get_Glyph;
extern fn FT_Get_Glyph(slot: GlyphSlot, aglyph: [*c]Glyph) Error;
pub const Glyph_Copy = FT_Glyph_Copy;
extern fn FT_Glyph_Copy(source: Glyph, target: [*c]Glyph) Error;
pub const Glyph_Transform = FT_Glyph_Transform;
extern fn FT_Glyph_Transform(glyph: Glyph, matrix: [*c]const Matrix, delta: [*c]const Vector) Error;
pub const Glyph_BBox_Mode = enum(c_uint) {
    UNSCALED = 0,
    SUBPIXELS = 0,
    GRIDFIT = 1,
    TRUNCATE = 2,
    PIXELS = 3,
};
pub const Glyph_Get_CBox = FT_Glyph_Get_CBox;
extern fn FT_Glyph_Get_CBox(glyph: Glyph, bbox_mode: UInt, acbox: [*c]BBox) void;
pub const Glyph_To_Bitmap = FT_Glyph_To_Bitmap;
extern fn FT_Glyph_To_Bitmap(the_glyph: [*c]Glyph, render_mode: Render_Mode, origin: [*c]const Vector, destroy: Bool) Error;
pub const Done_Glyph = FT_Done_Glyph;
extern fn FT_Done_Glyph(glyph: Glyph) void;
pub const Matrix_Multiply = FT_Matrix_Multiply;
extern fn FT_Matrix_Multiply(a: [*c]const Matrix, b: [*c]Matrix) void;
pub const Matrix_Invert = FT_Matrix_Invert;
extern fn FT_Matrix_Invert(matrix: [*c]Matrix) Error;
pub const StrokerRec = opaque {};
pub const Stroker = ?*StrokerRec;
pub const Stroker_LineJoin = enum(c_uint) {
    ROUND = 0,
    BEVEL = 1,
    MITER_VARIABLE = 2,
    MITER = 2,
    MITER_FIXED = 3,
};
pub const Stroker_LineCap = enum(c_uint) {
    BUTT = 0,
    ROUND = 1,
    SQUARE = 2,
};
pub const StrokerBorder = enum(c_uint) {
    LEFT = 0,
    RIGHT = 1,
};
pub const Outline_GetInsideBorder = FT_Outline_GetInsideBorder;
extern fn FT_Outline_GetInsideBorder(outline: [*c]Outline) StrokerBorder;
pub const Outline_GetOutsideBorder = FT_Outline_GetOutsideBorder;
extern fn FT_Outline_GetOutsideBorder(outline: [*c]Outline) StrokerBorder;
pub const Stroker_New = FT_Stroker_New;
extern fn FT_Stroker_New(library: Library, astroker: [*c]Stroker) Error;
pub const Stroker_Set = FT_Stroker_Set;
extern fn FT_Stroker_Set(stroker: Stroker, radius: Fixed, line_cap: Stroker_LineCap, line_join: Stroker_LineJoin, miter_limit: Fixed) void;
pub const Stroker_Rewind = FT_Stroker_Rewind;
extern fn FT_Stroker_Rewind(stroker: Stroker) void;
pub const Stroker_ParseOutline = FT_Stroker_ParseOutline;
extern fn FT_Stroker_ParseOutline(stroker: Stroker, outline: [*c]Outline, opened: Bool) Error;
pub const Stroker_BeginSubPath = FT_Stroker_BeginSubPath;
extern fn FT_Stroker_BeginSubPath(stroker: Stroker, to: [*c]Vector, open: Bool) Error;
pub const Stroker_EndSubPath = FT_Stroker_EndSubPath;
extern fn FT_Stroker_EndSubPath(stroker: Stroker) Error;
pub const Stroker_LineTo = FT_Stroker_LineTo;
extern fn FT_Stroker_LineTo(stroker: Stroker, to: [*c]Vector) Error;
pub const Stroker_ConicTo = FT_Stroker_ConicTo;
extern fn FT_Stroker_ConicTo(stroker: Stroker, control: [*c]Vector, to: [*c]Vector) Error;
pub const Stroker_CubicTo = FT_Stroker_CubicTo;
extern fn FT_Stroker_CubicTo(stroker: Stroker, control1: [*c]Vector, control2: [*c]Vector, to: [*c]Vector) Error;
pub const Stroker_GetBorderCounts = FT_Stroker_GetBorderCounts;
extern fn FT_Stroker_GetBorderCounts(stroker: Stroker, border: StrokerBorder, anum_points: [*c]UInt, anum_contours: [*c]UInt) Error;
pub const Stroker_ExportBorder = FT_Stroker_ExportBorder;
extern fn FT_Stroker_ExportBorder(stroker: Stroker, border: StrokerBorder, outline: [*c]Outline) void;
pub const Stroker_GetCounts = FT_Stroker_GetCounts;
extern fn FT_Stroker_GetCounts(stroker: Stroker, anum_points: [*c]UInt, anum_contours: [*c]UInt) Error;
pub const Stroker_Export = FT_Stroker_Export;
extern fn FT_Stroker_Export(stroker: Stroker, outline: [*c]Outline) void;
pub const Stroker_Done = FT_Stroker_Done;
extern fn FT_Stroker_Done(stroker: Stroker) void;
pub const Glyph_Stroke = FT_Glyph_Stroke;
extern fn FT_Glyph_Stroke(pglyph: [*c]Glyph, stroker: Stroker, destroy: Bool) Error;
pub const Glyph_StrokeBorder = FT_Glyph_StrokeBorder;
extern fn FT_Glyph_StrokeBorder(pglyph: [*c]Glyph, stroker: Stroker, inside: Bool, destroy: Bool) Error;
pub const Angle = Fixed;
pub const Sin = FT_Sin;
extern fn FT_Sin(angle: Angle) Fixed;
pub const Cos = FT_Cos;
extern fn FT_Cos(angle: Angle) Fixed;
pub const Tan = FT_Tan;
extern fn FT_Tan(angle: Angle) Fixed;
pub const Atan2 = FT_Atan2;
extern fn FT_Atan2(x: Fixed, y: Fixed) Angle;
pub const Angle_Diff = FT_Angle_Diff;
extern fn FT_Angle_Diff(angle1: Angle, angle2: Angle) Angle;
pub extern fn Vector_Unit(vec: [*c]Vector, angle: Angle) void;
pub extern fn Vector_Rotate(vec: [*c]Vector, angle: Angle) void;
pub extern fn Vector_Length(vec: [*c]Vector) Fixed;
pub extern fn Vector_Polarize(vec: [*c]Vector, length: [*c]Fixed, angle: [*c]Angle) void;
pub extern fn Vector_From_Polar(vec: [*c]Vector, length: Fixed, angle: Angle) void;
pub const GlyphSlot_Embolden = FT_GlyphSlot_Embolden;
extern fn FT_GlyphSlot_Embolden(slot: GlyphSlot) void;
pub const GlyphSlot_AdjustWeight = FT_GlyphSlot_AdjustWeight;
extern fn FT_GlyphSlot_AdjustWeight(slot: GlyphSlot, xdelta: Fixed, ydelta: Fixed) void;
pub const GlyphSlot_Oblique = FT_GlyphSlot_Oblique;
extern fn FT_GlyphSlot_Oblique(slot: GlyphSlot) void;
pub const GlyphSlot_Slant = FT_GlyphSlot_Slant;
extern fn FT_GlyphSlot_Slant(slot: GlyphSlot, xslant: Fixed, yslant: Fixed) void;
pub const TT_CONFIG_OPTION_MAX_RUNNABLE_OPCODES = @as(c_long, 1000000);
pub const T1_MAX_DICT_DEPTH = @as(c_int, 5);
pub const T1_MAX_SUBRS_CALLS = @as(c_int, 16);
pub const T1_MAX_CHARSTRINGS_OPERANDS = @as(c_int, 256);
pub const CFF_CONFIG_OPTION_DARKENING_PARAMETER_X1 = @as(c_int, 500);
pub const CFF_CONFIG_OPTION_DARKENING_PARAMETER_Y1 = @as(c_int, 400);
pub const CFF_CONFIG_OPTION_DARKENING_PARAMETER_X2 = @as(c_int, 1000);
pub const CFF_CONFIG_OPTION_DARKENING_PARAMETER_Y2 = @as(c_int, 275);
pub const CFF_CONFIG_OPTION_DARKENING_PARAMETER_X3 = @as(c_int, 1667);
pub const CFF_CONFIG_OPTION_DARKENING_PARAMETER_Y3 = @as(c_int, 275);
pub const CFF_CONFIG_OPTION_DARKENING_PARAMETER_X4 = @as(c_int, 2333);
pub const CFF_CONFIG_OPTION_DARKENING_PARAMETER_Y4 = @as(c_int, 0);
pub const USHRT_MAX = @as(c_uint, 0xffff);
pub const INT64 = c_longlong;
pub const UINT64 = c_ulonglong;
pub const INT64_ZERO = @as(c_int, 0);
pub const EXPORT = @compileError("unable to translate C expr: unexpected token 'extern'");
// .\external\freetype\include/freetype/config/public-macros.h:104:9
pub const UNUSED = @compileError("unable to translate C expr: expected ')' instead got '='");
// .\external\freetype\include/freetype/config/public-macros.h:115:9
pub const STATIC_CAST = @import("std").zig.c_translation.Macros.CAST_OR_CALL;
pub const REINTERPRET_CAST = @import("std").zig.c_translation.Macros.CAST_OR_CALL;
pub inline fn STATIC_BYTE_CAST(@"type": anytype, @"var": anytype) @TypeOf(@"type"(u8)(@"var")) {
    _ = &@"type";
    _ = &@"var";
    return @"type"(u8)(@"var");
}
pub const OUTLINE_CONTOURS_MAX = USHRT_MAX;
pub const OUTLINE_POINTS_MAX = USHRT_MAX;
pub const OUTLINE_NONE = @as(c_int, 0x0);
pub const OUTLINE_OWNER = @as(c_int, 0x1);
pub const OUTLINE_EVEN_ODD_FILL = @as(c_int, 0x2);
pub const OUTLINE_REVERSE_FILL = @as(c_int, 0x4);
pub const OUTLINE_IGNORE_DROPOUTS = @as(c_int, 0x8);
pub const OUTLINE_SMART_DROPOUTS = @as(c_int, 0x10);
pub const OUTLINE_INCLUDE_STUBS = @as(c_int, 0x20);
pub const OUTLINE_OVERLAP = @as(c_int, 0x40);
pub const OUTLINE_HIGH_PRECISION = @as(c_int, 0x100);
pub const OUTLINE_SINGLE_PASS = @as(c_int, 0x200);
pub const outline_none = OUTLINE_NONE;
pub const outline_owner = OUTLINE_OWNER;
pub const outline_even_odd_fill = OUTLINE_EVEN_ODD_FILL;
pub const outline_reverse_fill = OUTLINE_REVERSE_FILL;
pub const outline_ignore_dropouts = OUTLINE_IGNORE_DROPOUTS;
pub const outline_high_precision = OUTLINE_HIGH_PRECISION;
pub const outline_single_pass = OUTLINE_SINGLE_PASS;
pub inline fn CURVE_TAG(flag: anytype) @TypeOf(flag & @as(c_int, 0x03)) {
    _ = &flag;
    return flag & @as(c_int, 0x03);
}
pub const CURVE_TAG_ON = @as(c_int, 0x01);
pub const CURVE_TAG_CONIC = @as(c_int, 0x00);
pub const CURVE_TAG_CUBIC = @as(c_int, 0x02);
pub const CURVE_TAG_HAS_SCANMODE = @as(c_int, 0x04);
pub const CURVE_TAG_TOUCH_X = @as(c_int, 0x08);
pub const CURVE_TAG_TOUCH_Y = @as(c_int, 0x10);
pub const CURVE_TAG_TOUCH_BOTH = CURVE_TAG_TOUCH_X | CURVE_TAG_TOUCH_Y;
pub const Curve_Tag_On = CURVE_TAG_ON;
pub const Curve_Tag_Conic = CURVE_TAG_CONIC;
pub const Curve_Tag_Cubic = CURVE_TAG_CUBIC;
pub const Curve_Tag_Touch_X = CURVE_TAG_TOUCH_X;
pub const Curve_Tag_Touch_Y = CURVE_TAG_TOUCH_Y;
pub const Outline_MoveTo_Func = Outline_MoveToFunc;
pub const Outline_LineTo_Func = Outline_LineToFunc;
pub const Outline_ConicTo_Func = Outline_ConicToFunc;
pub const Outline_CubicTo_Func = Outline_CubicToFunc;
pub const IMAGE_TAG = @compileError("unable to translate C expr: unexpected token '='");
// .\external\freetype\include/freetype/ftimage.h:714:9
pub const Raster_Span_Func = SpanFunc;
pub const RASTER_FLAG_DEFAULT = @as(c_int, 0x0);
pub const RASTER_FLAG_AA = @as(c_int, 0x1);
pub const RASTER_FLAG_DIRECT = @as(c_int, 0x2);
pub const RASTER_FLAG_CLIP = @as(c_int, 0x4);
pub const RASTER_FLAG_SDF = @as(c_int, 0x8);
pub const raster_flag_default = RASTER_FLAG_DEFAULT;
pub const raster_flag_aa = RASTER_FLAG_AA;
pub const raster_flag_direct = RASTER_FLAG_DIRECT;
pub const raster_flag_clip = RASTER_FLAG_CLIP;
pub const Raster_New_Func = Raster_NewFunc;
pub const Raster_Done_Func = Raster_DoneFunc;
pub const Raster_Reset_Func = Raster_ResetFunc;
pub const Raster_Set_Mode_Func = Raster_SetModeFunc;
pub const Raster_Render_Func = Raster_RenderFunc;
pub inline fn MAKE_TAG(_x1: anytype, _x2: anytype, _x3: anytype, _x4: anytype) @TypeOf((((STATIC_BYTE_CAST(Tag, _x1) << @as(c_int, 24)) | (STATIC_BYTE_CAST(Tag, _x2) << @as(c_int, 16))) | (STATIC_BYTE_CAST(Tag, _x3) << @as(c_int, 8))) | STATIC_BYTE_CAST(Tag, _x4)) {
    _ = &_x1;
    _ = &_x2;
    _ = &_x3;
    _ = &_x4;
    return (((STATIC_BYTE_CAST(Tag, _x1) << @as(c_int, 24)) | (STATIC_BYTE_CAST(Tag, _x2) << @as(c_int, 16))) | (STATIC_BYTE_CAST(Tag, _x3) << @as(c_int, 8))) | STATIC_BYTE_CAST(Tag, _x4);
}
pub inline fn IS_EMPTY(list: anytype) @TypeOf(list.head == @as(c_int, 0)) {
    _ = &list;
    return list.head == @as(c_int, 0);
}
pub const FACE_FLAG_SCALABLE = @as(c_long, 1) << @as(c_int, 0);
pub const FACE_FLAG_FIXED_SIZES = @as(c_long, 1) << @as(c_int, 1);
pub const FACE_FLAG_FIXED_WIDTH = @as(c_long, 1) << @as(c_int, 2);
pub const FACE_FLAG_SFNT = @as(c_long, 1) << @as(c_int, 3);
pub const FACE_FLAG_HORIZONTAL = @as(c_long, 1) << @as(c_int, 4);
pub const FACE_FLAG_VERTICAL = @as(c_long, 1) << @as(c_int, 5);
pub const FACE_FLAG_KERNING = @as(c_long, 1) << @as(c_int, 6);
pub const FACE_FLAG_FAST_GLYPHS = @as(c_long, 1) << @as(c_int, 7);
pub const FACE_FLAG_MULTIPLE_MASTERS = @as(c_long, 1) << @as(c_int, 8);
pub const FACE_FLAG_GLYPH_NAMES = @as(c_long, 1) << @as(c_int, 9);
pub const FACE_FLAG_EXTERNAL_STREAM = @as(c_long, 1) << @as(c_int, 10);
pub const FACE_FLAG_HINTER = @as(c_long, 1) << @as(c_int, 11);
pub const FACE_FLAG_CID_KEYED = @as(c_long, 1) << @as(c_int, 12);
pub const FACE_FLAG_TRICKY = @as(c_long, 1) << @as(c_int, 13);
pub const FACE_FLAG_COLOR = @as(c_long, 1) << @as(c_int, 14);
pub const FACE_FLAG_VARIATION = @as(c_long, 1) << @as(c_int, 15);
pub const FACE_FLAG_SVG = @as(c_long, 1) << @as(c_int, 16);
pub const FACE_FLAG_SBIX = @as(c_long, 1) << @as(c_int, 17);
pub const FACE_FLAG_SBIX_OVERLAY = @as(c_long, 1) << @as(c_int, 18);
pub inline fn HAS_HORIZONTAL(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_HORIZONTAL) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_HORIZONTAL) != 0);
}
pub inline fn HAS_VERTICAL(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_VERTICAL) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_VERTICAL) != 0);
}
pub inline fn HAS_KERNING(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_KERNING) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_KERNING) != 0);
}
pub inline fn IS_SCALABLE(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_SCALABLE) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_SCALABLE) != 0);
}
pub inline fn IS_SFNT(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_SFNT) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_SFNT) != 0);
}
pub inline fn IS_FIXED_WIDTH(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_FIXED_WIDTH) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_FIXED_WIDTH) != 0);
}
pub inline fn HAS_FIXED_SIZES(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_FIXED_SIZES) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_FIXED_SIZES) != 0);
}
pub inline fn HAS_FAST_GLYPHS(face: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &face;
    return @as(c_int, 0);
}
pub inline fn HAS_GLYPH_NAMES(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_GLYPH_NAMES) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_GLYPH_NAMES) != 0);
}
pub inline fn HAS_MULTIPLE_MASTERS(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_MULTIPLE_MASTERS) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_MULTIPLE_MASTERS) != 0);
}
pub inline fn IS_NAMED_INSTANCE(face: anytype) @TypeOf(!!((face.*.face_index & @as(c_long, 0x7FFF0000)) != 0)) {
    _ = &face;
    return !!((face.*.face_index & @as(c_long, 0x7FFF0000)) != 0);
}
pub inline fn IS_VARIATION(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_VARIATION) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_VARIATION) != 0);
}
pub inline fn IS_CID_KEYED(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_CID_KEYED) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_CID_KEYED) != 0);
}
pub inline fn IS_TRICKY(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_TRICKY) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_TRICKY) != 0);
}
pub inline fn HAS_COLOR(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_COLOR) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_COLOR) != 0);
}
pub inline fn HAS_SVG(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_SVG) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_SVG) != 0);
}
pub inline fn HAS_SBIX(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_SBIX) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_SBIX) != 0);
}
pub inline fn HAS_SBIX_OVERLAY(face: anytype) @TypeOf(!!((face.*.face_flags & FACE_FLAG_SBIX_OVERLAY) != 0)) {
    _ = &face;
    return !!((face.*.face_flags & FACE_FLAG_SBIX_OVERLAY) != 0);
}
pub const STYLE_FLAG_ITALIC = @as(c_int, 1) << @as(c_int, 0);
pub const STYLE_FLAG_BOLD = @as(c_int, 1) << @as(c_int, 1);
pub const OPEN_MEMORY = @as(c_int, 0x1);
pub const OPEN_STREAM = @as(c_int, 0x2);
pub const OPEN_PATHNAME = @as(c_int, 0x4);
pub const OPEN_DRIVER = @as(c_int, 0x8);
pub const OPEN_PARAMS = @as(c_int, 0x10);
pub const LOAD_DEFAULT = @as(c_int, 0x0);
pub const LOAD_NO_SCALE = @as(c_long, 1) << @as(c_int, 0);
pub const LOAD_NO_HINTING = @as(c_long, 1) << @as(c_int, 1);
pub const LOAD_RENDER = @as(c_long, 1) << @as(c_int, 2);
pub const LOAD_NO_BITMAP = @as(c_long, 1) << @as(c_int, 3);
pub const LOAD_VERTICAL_LAYOUT = @as(c_long, 1) << @as(c_int, 4);
pub const LOAD_FORCE_AUTOHINT = @as(c_long, 1) << @as(c_int, 5);
pub const LOAD_CROP_BITMAP = @as(c_long, 1) << @as(c_int, 6);
pub const LOAD_PEDANTIC = @as(c_long, 1) << @as(c_int, 7);
pub const LOAD_IGNORE_GLOBAL_ADVANCE_WIDTH = @as(c_long, 1) << @as(c_int, 9);
pub const LOAD_NO_RECURSE = @as(c_long, 1) << @as(c_int, 10);
pub const LOAD_IGNORE_TRANSFORM = @as(c_long, 1) << @as(c_int, 11);
pub const LOAD_MONOCHROME = @as(c_long, 1) << @as(c_int, 12);
pub const LOAD_LINEAR_DESIGN = @as(c_long, 1) << @as(c_int, 13);
pub const LOAD_SBITS_ONLY = @as(c_long, 1) << @as(c_int, 14);
pub const LOAD_NO_AUTOHINT = @as(c_long, 1) << @as(c_int, 15);
pub const LOAD_COLOR = @as(c_long, 1) << @as(c_int, 20);
pub const LOAD_COMPUTE_METRICS = @as(c_long, 1) << @as(c_int, 21);
pub const LOAD_BITMAP_METRICS_ONLY = @as(c_long, 1) << @as(c_int, 22);
pub const LOAD_NO_SVG = @as(c_long, 1) << @as(c_int, 24);
pub const LOAD_ADVANCE_ONLY = @as(c_long, 1) << @as(c_int, 8);
pub const LOAD_SVG_ONLY = @as(c_long, 1) << @as(c_int, 23);
pub inline fn LOAD_TARGET_(x: Render_Mode) Int32 {
    const as_int: c_int = @enumFromInt(x);
    return as_int & @as(c_int, 15) << @as(c_int, 16);
}
pub const LOAD_TARGET_NORMAL = LOAD_TARGET_(.NORMAL);
pub const LOAD_TARGET_LIGHT = LOAD_TARGET_(.LIGHT);
pub const LOAD_TARGET_MONO = LOAD_TARGET_(.MONO);
pub const LOAD_TARGET_LCD = LOAD_TARGET_(.LCD);
pub const LOAD_TARGET_LCD_V = LOAD_TARGET_(.LCD_V);
pub inline fn LOAD_TARGET_MODE(x: c_int) Render_Mode {
    _ = &x;
    return STATIC_CAST(Render_Mode, (x >> @as(c_int, 16)) & @as(c_int, 15));
}
pub const SUBGLYPH_FLAG_ARGS_ARE_WORDS = @as(c_int, 1);
pub const SUBGLYPH_FLAG_ARGS_ARE_XY_VALUES = @as(c_int, 2);
pub const SUBGLYPH_FLAG_ROUND_XY_TO_GRID = @as(c_int, 4);
pub const SUBGLYPH_FLAG_SCALE = @as(c_int, 8);
pub const SUBGLYPH_FLAG_XY_SCALE = @as(c_int, 0x40);
pub const SUBGLYPH_FLAG_2X2 = @as(c_int, 0x80);
pub const SUBGLYPH_FLAG_USE_MY_METRICS = @as(c_int, 0x200);
pub const FSTYPE_INSTALLABLE_EMBEDDING = @as(c_int, 0x0000);
pub const FSTYPE_RESTRICTED_LICENSE_EMBEDDING = @as(c_int, 0x0002);
pub const FSTYPE_PREVIEW_AND_PRINT_EMBEDDING = @as(c_int, 0x0004);
pub const FSTYPE_EDITABLE_EMBEDDING = @as(c_int, 0x0008);
pub const FSTYPE_NO_SUBSETTING = @as(c_int, 0x0100);
pub const FSTYPE_BITMAP_EMBEDDING_ONLY = @as(c_int, 0x0200);
pub const FREETYPE_MAJOR = @as(c_int, 2);
pub const FREETYPE_MINOR = @as(c_int, 13);
pub const FREETYPE_PATCH = @as(c_int, 3);
pub const ADVANCE_FLAG_FAST_ONLY = @as(c_long, 0x20000000);
pub const PALETTE_FOR_LIGHT_BACKGROUND = @as(c_int, 0x01);
pub const PALETTE_FOR_DARK_BACKGROUND = @as(c_int, 0x02);
pub const PARAM_TAG_IGNORE_TYPOGRAPHIC_FAMILY = MAKE_TAG('i', 'g', 'p', 'f');
pub const PARAM_TAG_IGNORE_PREFERRED_FAMILY = PARAM_TAG_IGNORE_TYPOGRAPHIC_FAMILY;
pub const PARAM_TAG_IGNORE_TYPOGRAPHIC_SUBFAMILY = MAKE_TAG('i', 'g', 'p', 's');
pub const PARAM_TAG_IGNORE_PREFERRED_SUBFAMILY = PARAM_TAG_IGNORE_TYPOGRAPHIC_SUBFAMILY;
pub const PARAM_TAG_INCREMENTAL = MAKE_TAG('i', 'n', 'c', 'r');
pub const PARAM_TAG_IGNORE_SBIX = MAKE_TAG('i', 's', 'b', 'x');
pub const PARAM_TAG_LCD_FILTER_WEIGHTS = MAKE_TAG('l', 'c', 'd', 'f');
pub const PARAM_TAG_RANDOM_SEED = MAKE_TAG('s', 'e', 'e', 'd');
pub const PARAM_TAG_STEM_DARKENING = MAKE_TAG('d', 'a', 'r', 'k');
pub const PARAM_TAG_UNPATENTED_HINTING = MAKE_TAG('u', 'n', 'p', 'a');
pub const LCD_FILTER_FIVE_TAPS = @as(c_int, 5);
