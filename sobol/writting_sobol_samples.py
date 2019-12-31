#!/usr/bin/env python
# coding: utf-8

# In[50]:


import numpy as np
import pandas as pd
import json
import pickle
import csv
from pandas.io.json import json_normalize
import scipy
import SALib
from SALib.sample import saltelli
    
def writting_files(str_values, counter):

#     import itertools

    soc,pv,ph,cn = str_values 
    
    class NpEncoder(json.JSONEncoder):
        def default(self, obj):
            if isinstance(obj, np.integer):
                return int(obj)
            elif isinstance(obj, np.floating):
                return float(obj)
            elif isinstance(obj, np.ndarray):
                return obj.tolist()
            else:
                return super(NpEncoder, self).default(obj)

    site_file = './work_kshen/site-min-kshen.json' #site-min-kshen-3-layers.json'
    sim_file = './work_kshen/sim-min-kshen.json'

#     soil_texture_pd = pd.read_csv('SoilTexture.csv', sep=";") 
#     soil_texture = np.asarray(soil_texture_pd.iloc[:,[0,2,4,5,6,7]])

    with open(site_file) as sf:
        site_data = json.load(sf)

    with open(sim_file) as simf:
        sim_data = json.load(simf)   

    #selecting necessary keys
    keys = list(site_data['SiteParameters']['SoilProfileParameters'][0].keys())
#     texture_keys = list(keys.copy()[i] for i in [3,4,7,8,11])
    our_keys = list(keys.copy()[i] for i in [1,6,9,10])

    #creating range for every soil parameter
#     organic_carbon_range=np.arange(2.58,6.20,0.4)
#     texture_class_range=list(soil_texture_pd['KA5-class'])
#     pore_volume_range=np.arange(0.48,0.67,0.02)
#     ph_range=np.arange(4.6,6.9,0.25)
#     cn_range=np.arange(10.9,12.4,0.15)
    
    
    soc=soc
    pv=pv
    ph=ph
    cn=cn


#     soil_parameters_range = [organic_carbon_range,texture_class_range,pore_volume_range,
#                              ph_range,cn_range]

    

    soil_parameters_names = ['SOC', 'PV', 'pH', 'CN']


    #saving site-file and sim-file
    #for the first key - SoilOrganicCarbon
    # for parameter in range(len(soil_parameters_range)):
#     for soc,ka5,pv,ph,cn in itertools.product(soil_parameters_range[0],soil_parameters_range[1],\
#                                               soil_parameters_range[2],soil_parameters_range[3],soil_parameters_range[4]):

    site_data_copy=site_data.copy()

    #writing main parameters
    site_data_copy['SiteParameters']['SoilProfileParameters'][0][our_keys[0]][0]=float(soc) 
#     site_data_copy['SiteParameters']['SoilProfileParameters'][0][our_keys[1]]=ka5
    site_data_copy['SiteParameters']['SoilProfileParameters'][0][our_keys[1]][0]=float(pv)
    site_data_copy['SiteParameters']['SoilProfileParameters'][0][our_keys[2]][0]=float(ph)
    site_data_copy['SiteParameters']['SoilProfileParameters'][0][our_keys[3]][0]=float(cn)


    #writing texture parameters
#     for c in range(len(texture_keys)):
#         data = soil_texture[np.where(soil_texture==ka5)[0][0],:][1:]
#         site_data_copy['SiteParameters']['SoilProfileParameters'][0][texture_keys[c]][0]=data[c]

    #constructing file name 
    SOC_value = str(site_data_copy['SiteParameters']['SoilProfileParameters'][0][our_keys[0]][0])
#     KA5_value = '_KA5' + str(site_data_copy['SiteParameters']['SoilProfileParameters'][0][our_keys[1]])
    PV_value = str(site_data_copy['SiteParameters']['SoilProfileParameters'][0][our_keys[1]][0])
    ph_value =  str(site_data_copy['SiteParameters']['SoilProfileParameters'][0][our_keys[2]][0])
    CN_value =  str(site_data_copy['SiteParameters']['SoilProfileParameters'][0][our_keys[3]][0])


    file_name = str(SOC_value)+'_'+str(PV_value)+'_'+str(ph_value)+'_'+str(CN_value)
    site_file_name='site'+'_'+file_name+'.json'


    with open(site_file_name, 'w', encoding='utf-8') as sitef:
        json.dump(site_data_copy, sitef, ensure_ascii=False, indent=4, cls=NpEncoder)

    sim_data_copy=sim_data.copy()
    sim_data_copy['site.json']=site_file_name
    sim_data_copy['output']['file-name']=str(counter)+'out'+'_'+file_name+'.csv'
    sim_file_name='sim'+'_'+file_name+'.json'

    with open(sim_file_name, 'w', encoding='utf-8') as simf:
        json.dump(sim_data_copy, simf, ensure_ascii=False,                   indent=4, cls=NpEncoder)
            
        


# In[51]:


problem = {
    'num_vars':4,
    'names':['SOC', 'PV', 'pH', 'CN'],
    'bounds':[[2.58, 6.20],
              [0.48, 0.67],
              [4.6, 6.9],
              [10.9, 12.4]]
}


# In[57]:


param_values = saltelli.sample(problem, 1000)


# In[56]:
counter=1000000
for st in range(len(param_values)):
    writting_files(param_values[st], counter)
    counter+=1

# In[ ]:




