import bpy
import os
import sys

scene = bpy.data.scenes
context = bpy.context
sce_cont = context.scene 
obs = context.selected_objects
# bpy.context.view_layer.objects.active = bpy.context.scene.camera

root_folder = r"V:\PAPA\Output\3_OutputRender\PAPA_Movie\REEL_06\1. EXT. FINALE BATTLE, YCORE ROOFTOP - NIGHT"
# script_path = r"P:\Common\Share\Didi\Blender\fx_dome_path.py"
    
folder = bpy.data.filepath
full_path = os.path.dirname(folder)


def get_1st_lvl():
    filepath =  bpy.data.filepath
    full_path = os.path.dirname(filepath)
    #print("full path: ", full_path)
    return(full_path)  

def get_workpath():
    #filepath = bpy.data.filepath
    if sys.platform.startswith("win32"): 
         blendpath = '\\'.join(filepath.split('\\')[7:8]) + '\\'
    else:
         blendpath = '/'.join(filepath.split('/')[7:8]) + '/'
    #print('blendpath: ', blendpath)
    return(blendpath)   

def get_shotname():
    filename = bpy.path.basename(bpy.context.blend_data.filepath)
    basename, extension = os.path.splitext(filename)
    new_basename = basename[:-7]  # Remove "_Render"
    #print('new_basename: ', new_basename)
    return new_basename
        
def set_renderpath():
    path = r"V:\PAPA\Output\3_OutputRender\PAPA_Movie\REEL_06\1. EXT. FINALE BATTLE, YCORE ROOFTOP - NIGHT"
    return(path)

def set_pr():
    filepath = bpy.data.filepath
    if sys.platform.startswith("win32"): 
         pr_path = '\\'.join(filepath.split('\\')[:8]) + '\\'
    else:
         pr_path = '/'.join(filepath.split('/')[:15]) + '/'
    #print(pr_path)
    return(pr_path)

scene = bpy.context.scene
renderpath = set_renderpath()
shotname = get_shotname()
pr_folder = set_pr()
owner = 'DD'
prerender = 'PreRender'

local_scenes = [s for s in bpy.data.scenes if not s.library]

bpy.data.scenes["FX"].render.filepath = renderpath + '\\' + shotname + '\\' + 'FX_Blender' + '\\' + 'FX_Dome_2' + '\\' + '_'

scenes = [s for s in local_scenes]

output_nodes = [n for s in scenes for n in s.node_tree.nodes if n.type == "OUTPUT_FILE"]
for node in output_nodes:
    node.format.file_format = "PNG"
    node.format.color_depth = "16"
    #node.format.color_mode = "RGBA"
    if sys.platform.startswith("win32"): # windows platform 
        if "Matte" in node.name:
            pass_name = 'Matte'
            node_name = node.label.split("_")[0]
            node.base_path = os.path.join(renderpath + '\\' + shotname + '\\' + 'FX_Blender' + '\\' + 'FX_Dome_2' + '\\' + node_name + '\\' + pass_name + '\\')
            node.format.file_format = "OPEN_EXR_MULTILAYER"
            node.format.color_mode = "RGBA"
            node.format.color_depth = "32"
        
        elif "Node" in node.name:
            folder = node.label
            filename = node.file_slots.keys()[0]
            node_output = os.path.join(renderpath + '\\' + shotname + '\\' + 'FX_Blender' + '\\' + 'FX_Dome_2' + '\\' + folder + '\\')
            node.base_path = node_output
            node.file_slots[filename].path = folder + '_'
                                
        else:
            folder = node.label.split("_")[0]
            pass_name = node.name.split(".")[0]
            filename = node.file_slots.keys()[0]
            node_output = os.path.join(renderpath + '\\' + shotname + '\\' + 'FX_Blender' + '\\' + 'FX_Dome_2' + '\\' + folder  + '\\' + pass_name + '\\' )
            node.base_path = node_output
            node.file_slots[filename].path = os.path.join(pass_name + '_')

global_camera = bpy.data.scenes["FX"].camera
frame_start = bpy.data.scenes["FX"].frame_start
frame_end = bpy.data.scenes["FX"].frame_end

for scn in bpy.data.scenes:
    scn.camera = global_camera
    scn.frame_start = frame_start
    scn.frame_end = frame_end

