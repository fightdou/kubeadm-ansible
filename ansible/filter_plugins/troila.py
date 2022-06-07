def listintersection(source_list, dest_list):
    """This function returns the intersection of the passed collections

    :return: Returns the value of the unit conversion, is a type type.

    """
    if not isinstance (source_list, list):
         raise ValueError("source_list:[{}] must is a list type".format(source_list))
    if not isinstance (dest_list, list):
         raise ValueError("dest_list:[{}] must is a list type".format(dest_list))

    source_set = set(source_list)
    dest_set = set(dest_list)
    re_list = sorted(list(source_set & dest_set))

    return re_list

# ---- Ansible filters ----
class FilterModule(object):

    def filters(self):
        return {
            'listintersection': listintersection
            }