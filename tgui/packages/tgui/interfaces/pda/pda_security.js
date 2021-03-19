import { filter } from 'common/collections';
import { decodeHtmlEntities, toTitleCase } from 'common/string';
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from "../../backend";
import { Box, Button, Flex, Icon, LabeledList, ProgressBar, Section } from "../../components";

export const pda_security = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    recordsList,
    records,
  } = data;

  if (records) {
    const {
      general,
      security,
    } = records;

    return (
      <Box>
        <Section level={2} title="Общие данные">
          {general && (
            <LabeledList>
              <LabeledList.Item label="Ф.И">
                {general.name}
              </LabeledList.Item>
              <LabeledList.Item label="Пол">
                {general.sex}
              </LabeledList.Item>
              <LabeledList.Item label="Раса">
                {general.species}
              </LabeledList.Item>
              <LabeledList.Item label="Возраст">
                {general.age}
              </LabeledList.Item>
              <LabeledList.Item label="Должность">
                {general.rank}
              </LabeledList.Item>
              <LabeledList.Item label="Отпечаток">
                {general.fingerprint}
              </LabeledList.Item>
              <LabeledList.Item label="физ. состояние">
                {general.p_stat}
              </LabeledList.Item>
              <LabeledList.Item label="Псих. состояние">
                {general.m_stat}
              </LabeledList.Item>
            </LabeledList>
          ) || (
            <Box color="bad">
              General record lost!
            </Box>
          )}
        </Section>
        <Section level={2} title="Данные безопасности">
          {security && (
            <LabeledList>
              <LabeledList.Item label="Статус">
                {security.criminal}
              </LabeledList.Item>
              <LabeledList.Item label="Minor Crimes">
                {security.mi_crim}
              </LabeledList.Item>
              <LabeledList.Item label="Details">
                {security.mi_crim_d}
              </LabeledList.Item>
              <LabeledList.Item label="Major Crimes">
                {security.ma_crim}
              </LabeledList.Item>
              <LabeledList.Item label="Details">
                {security.ma_crim_d}
              </LabeledList.Item>
              <LabeledList.Item label="Important Notes:">
                {security.notes}
              </LabeledList.Item>
            </LabeledList>
          ) || (
            <Box color="bad">
              Security record lost!
            </Box>
          )}
        </Section>
      </Box>
    );
  }

  return (
    <Section level={2} title="Select a record">
      {recordsList.map(record => (
        <Button
          key={record.ref}
          icon="eye"
          fluid
          content={record.Name}
          onClick={() => act("Records", { target: record.ref })} />
      ))}
    </Section>
  );
};